
class Q4Me::Client

    EXIT = 999

    attr_reader :table, :dbh, :owner

    def initialize(conn, table)
        if conn.kind_of? Hash then
            @dbh = DBI.connect(conn[:uri], conn[:user], conn[:pass])
        else
            @dbh = conn
        end
        @table = table
    end

    def wait_for_read(condition = nil)
        while true do
            ret = read(condition)
            return ret if not ret.nil?
        end
    end

    def read(condition = nil, timeout = 10)
        sth = dbh.execute("select * from #{table} WHERE queue_wait('#{table}', #{timeout});")
        ret = {}
        row = sth.fetch
        return nil if row.nil?
        row.each_with_name do |val, name|
            ret[name] = val
        end
        sth.finish
        @owner = true
        ret
    end

    def delete()
        dbh.do("select queue_end()") if @owner
    end

    def abort()
        dbh.do("select queue_abort()") if @owner
    end

    def handle_next(condition = nil, &block)
        row = wait_for_read(condition)
        begin
            ret = yield(row)
            delete()
            ret
        rescue Exception => ex
            return abort()
        end
    end

    def handle_loop(condition = nil, &block)
        while true
            ret = handle_next(condition, &block)
            return if ret == EXIT
        end
    end

end
