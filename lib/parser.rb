class Parser
    C_PUSH = 0
    C_POP = 1
    C_ARITHMETIC = 2

    def initialize(input)
        @remaining = input
    end

    def has_more_commands?
        @remaining =~ /^\s*[^\s\/]+.*$/
    end

    def command_type
        case @current[0]
        when 'push' then Parser::C_PUSH
        when 'pop' then Parser::C_POP
        else Parser::C_ARITHMETIC
        end
    end

    def advance
        begin
            line, _, @remaining = @remaining.partition("\n")
            # Strip trailing comments
            @current = line.partition('//').first.strip.split(' ')
        end while @current.empty?
    end

    def arg1
        case command_type
        when Parser::C_ARITHMETIC then @current[0]
        else @current[1]
        end
    end

    def arg2
        @current[2].to_i
    end
end
