class PingerWorker
  include Sidekiq::Worker

  def perform(address)
    @address_object = Address.find(address)
    @icmp = Net::Ping::ICMP.new(@address_object.name)
	@durations = []
	@counter = 0
	@lost_counter = 0

	loop do
		@counter += 1
		if @icmp.ping
			@durations << @icmp.duration
		else
			@lost_counter += 1
		end
		break if DateTime.current.to_i >= @address_object.end_time.to_i
	end

	@address_object.lost = (@lost_counter.to_f * 100)/@counter.to_f
	@address_object.average = (@durations.sum)/(@counter - @lost_counter)
	@address_object.minimun = @durations.min
	@address_object.maximum = @durations.max
	@address_object.save
	end
end
