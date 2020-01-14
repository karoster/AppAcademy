require 'json'

class Flash


    def initialize(req)
        #### flash data structs ####
        serialized_cookie = req.cookies['_rails_lite_app_flash']
        @new_cookie = {}
        @cookie = (serialized_cookie) ? JSON.parse(serialized_cookie) : {}
        #### flash.now data struct. ####
        @temp_content = {}
    end

    def now
      @temp_content
    end

    def [](key)
        key = key.to_s
        #return first hit on key. Want to check new cookies first to see if overidden
        #then check current cookies, if neither doesn't exist.
        return (@new_cookie[key] || @cookie[key] || nil)
    end

    def []=(key, val)
        key = key.to_s
        @new_cookie[key] = val
    end

    def store_flash(res)
        #only persist cookies that have been set in current session.
        #let old cookies (@cookies) die.

        res.set_cookie(
            '_rails_lite_app_flash', 
            path: '/', value: @new_cookie.to_json
      
          )
    end

end
