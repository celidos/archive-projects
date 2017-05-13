#ifndef XMPPCLIENT
#define XMPPCLIENT

#include "QXmppClient.h"

class xmppClient : public QXmppClient
{
    Q_OBJECT

public:
    xmppClient(QObject *parent = 0);
    ~xmppClient();

};

#endif // XMPPCLIENT

