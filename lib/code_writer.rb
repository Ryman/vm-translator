class CodeWriter
    attr_reader :output

    def initialize(output)
        @output = output
    end

    def set_file_name(name)
        # New file started
    end

    def write_arithmetic(command)
        case command
        when "add" then bin_op "M=D+M"
        when "sub" then bin_op "M=M-D"
        when "mul" then bin_op "M=D*M"
        when "and" then bin_op "M=D&M"
        when "or" then bin_op "M=D|M"
        when "neg" then op "M=-M"
        when "not" then op "M=!M"
        else raise "UNHANDLED"
        end
    end

    def write_push_pop(command, segment, index)

    end

    def op asm
        load_arg1
        write_asm asm
    end

    def load_arg1
        write_asm "@SP"
        write_asm "A=M-1"
    end

    def bin_op asm
        load_arg1
        load_arg2
        write_asm asm

        decrement_stack_pointer
    end

    def load_arg2
        write_asm "D=M"
        write_asm "A=A-1"
    end

    def decrement_stack_pointer
        write_asm "D=A+1"
        write_asm "@SP"
        write_asm "M=D"
    end

    def write_asm asm
        @output << asm
        @output << "\n" unless asm.end_with? "\n"
    end
end
