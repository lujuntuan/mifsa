#include <mifsa/gnss/platform_interface.h>

MIFSA_NAMESPACE_BEGIN

namespace Gnss {
class PlatformQnx : public PlatformInterface {
public:
    virtual std::string getNmea() override
    {
        return "empty";
    }
};

MIFSA_CREATE_PLATFORM(PlatformQnx, 1, 0);
}

MIFSA_NAMESPACE_END
