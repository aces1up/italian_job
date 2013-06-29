

  class PoolEach

      def initialize()

          @num_workers   = nil
          @workers       = []
          @jobs          = Queue.new

          @job_block     = nil
          @job_data      = nil

          @store         = nil
          @store_method  = nil

          @lock          = Mutex.new

      end

      def store_add( data )
          @lock.synchronize{
              @store.send( @store_method, data )
          }
      end

      def init_workers()
          @num_workers.times {
              @workers << Thread.new {

                begin
                  while !@jobs.empty? do

                    job_data = @jobs.pop
                    data, do_kill = @job_block.yield( job_data )

                    store_add( data ) if data and @store

                    if do_kill
                        puts "killing thread pool"
                        @jobs.clear
                        break
                    end

                  end
                rescue => err
                    puts "Thread Each error : #{err.message}\n#{err.backtrace}"
                end
              }
          }
      end

      def join()
          @workers.each do |thr| thr.join end
      end

      def init_jobs( job_count )
          job_count.times{ |count|
            data = @job_data.is_a?(Fixnum) ? count : @job_data[count]
            @jobs.push data
           }
      end

      def num_jobs()
          case
              when @job_data.is_a?(Fixnum) ; @job_data
          else
              @job_data.length
          end
      end

      def setup_store( store )
          @store        = store[:init]
          @store_method = store[:method]
      end

      def each( workers, job_data=nil, store=nil, &block )

          #  Job Data Controls how many jobs we queue up
          #  If its an integer that just how many jobs we run
          #  If its an array or hash then we queue up that length.

          @job_block   = block
          @num_workers = workers
          @job_data    = job_data
          setup_store( store ) if store


          init_jobs( num_jobs )
          init_workers()
          join()

          @store
      end
  end
