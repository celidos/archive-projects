function route(handle, pathname) 
{
	console.log(pathname);
	if (typeof handle[pathname] === 'function') {
		handle[pathname]();
	} else {
		console.log("Не знаю, что делать при " + pathname);
	}
}

exports.route = route;
