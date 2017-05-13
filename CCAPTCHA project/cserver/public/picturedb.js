/**
 * Created by elluzion on 21.09.14.
 */

var fs      = require('fs');
var request = require('request');
var path    = require('path');

function PictureDB(){
    this.picturedb = {
        size : 0
    };
    this.tagsdb = {
        size : 0
    };
    this.next_max_id = 0;
    this.n = 0;
    this.tag = 0;

    this.savePictureOnDisk = function(index){
        request.get({url: this.picturedb[index].smallurl, encoding: 'binary'}, function (err, response, body) {
            fs.writeFile(path.join(__dirname, "by_landscape/"+index+".jpg"), body, 'binary', function(err) {
                if(err)
                    console.log(err);
                else
                    console.log("The file on url "+index+" was saved!");
            }.bind(this));
        }.bind(this));
    };

    this.mycallback = function(err, res, body) {
        if (!err && res.statusCode == 200) {
            //console.log(body);
            //console.log(" ------ response finito ------- ");
            var data = JSON.parse(body);
            ++this.pagenumber;
            //console.log(data);
            for (var item in data.data) {
                //console.log(data.data[item]);
                //console.log("-------------------------------");
                var s = this.picturedb.size;
                this.picturedb[s] = {};
                this.picturedb[s].smallurl = data.data[item].images.thumbnail.url;
                this.savePictureOnDisk(s);
                this.picturedb[s].filename = this.picturedb.size;

                ++this.picturedb.size;
            }
            console.log("Операция I-запроса завершена успешно, размер базы стал равен " + this.picturedb.size);
            this.next_max_id = data.pagination.next_max_tag_id;
            console.log(data.pagination);
            --this.n;
            this.searchtag();
            //console.log(body);
        }
    }.bind(this);

    //this.mycallback.picturedb = this.picturedb;

    this.init = function()
    {
        console.log(this.picturedb.size);
        this.picturedb.size = 0;

    }.bind(this);

    this.searchtag = function()
    {
        if (this.n >= 0) {
            if (this.tag > this.tagsdb.size)

            console.log("ololo = " + this.picturedb.size);
            console.log("Запрос у Instagram | тег = "+this.tagsdb[this.tag]+" | next_max_id = " + this.next_max_id);
            request(
                /*'https://api.instagram.com/v1/tags/' + currenttag + '/media/recent?'+JSON.stringify(
                 {
                 min_tag_id : 100,
                 max_tag_id : 101,
                 client_id  : 'b4edb50dd0b2483b9e41996a592cf01c'
                 }),*/
                 'https://api.instagram.com/v1/tags/'+this.curtag+'/media/recent?min_tag_id=90&max_tag_id='+this.next_max_id+'&client_id=b4edb50dd0b2483b9e41996a592cf01c',
                this.mycallback);
        }
        else {
            this.n = 20;
            ++this.tag;
            this.searchtag();
        }

    }.bind(this);

    this.splittags = function(err, data){
        if (err) throw err;
        console.log("tagsdb: "+this.tagsdb);
        data.split(/\n/).forEach(function(line) {
            this.tagsdb[this.tagsdb.size] = line;
            ++this.tagsdb.size;
            console.log("Найден тэг №"+this.tagsdb.size+": " + line);
        }.bind(this));
        console.log("Тэги успешно получены.");

        /*for (var i = 0; i < this.tagsdb.size; ++i)
        {
            this.n = 20;
            this.curtag = this.tagsdb[i];
            this.next_max_id = 0;
            console.log("Ищем по тэгу " + this.curtag);
            this.searchtag();
        }*/
        this.searchtag();
        console.log(this.picturedb);
        console.log("ЖЖЖЖЖЖЖЖИИИИИИИИИИИИИГГГГГГГГГГААААААААА ДДДДДДДРЫЫЫЫЫЫЫЫЫЫГГГГГГАААААААА");
    }.bind(this);

    this.searchpictures = function(){
        console.log("Ищем теги...");
        fs.readFile(path.join(__dirname, 'tags.txt'), 'utf8', this.splittags);
    };
}

module.exports = PictureDB;