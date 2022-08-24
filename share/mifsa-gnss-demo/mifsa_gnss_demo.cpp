/*********************************************************************************
 *Copyright(C): Juntuan.Lu, 2020-2030, All rights reserved.
 *Author:  Juntuan.Lu
 *Version: 1.0
 *Date:  2022/04/01
 *Email: 931852884@qq.com
 *Description:
 *Others:
 *Function List:
 *History:
 **********************************************************************************/

#include <mifsa/gnss/client.h>

using namespace Mifsa;

int main(int argc, char* argv[])
{
    Gnss::Client client(argc, argv);
    client.detectConnect([&](bool connect) {
        if (connect) {
            client.interface()->startNavigation([&](const Gnss::Location& location) {
                LOG_DEBUG("***** print Gnss::Location");
                const std::string& nmea = client.interface()->getNmea();
                LOG_PROPERTY("nmea", nmea);
                LOG_PROPERTY("size", location.size);
                LOG_PROPERTY("flags", location.flags);
                LOG_PROPERTY("latitude", location.latitude);
                LOG_PROPERTY("longitude", location.longitude);
                LOG_PROPERTY("altitude", location.altitude);
                LOG_PROPERTY("speed", location.speed);
                LOG_PROPERTY("bearing", location.bearing);
                LOG_PROPERTY("accuracy", location.accuracy);
                LOG_PROPERTY("timestamp", location.timestamp);
                LOG_DEBUG("*****");
            });
        }
    });
    return client.exec();
}
