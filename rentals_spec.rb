require 'rspec'

require_relative 'rentals'

describe User do
	it 'has many cars' do
		sam = User.create(name: 'Sam',
			state: 'DC',
			age: 26)
		expect(sam).to respond_to :cars
	end

	# stretch - uncomment to run the test
	it 'must be 25 or older' do
		molly = User.create(name: 'Molly', state: 'NY', age: 23)
		expect(molly.errors.messages[:age]).to include('must be greater than or equal to 25')
	end
end

describe Car do
	it 'has many rentals' do
		car = Car.create(make:'Toyota', model:'Prius', state: 'NY', license_plate: 'AGY3559', year: 2010)
		expect(car).to respond_to :rentals
	end

	# stretch - uncomment to run the test
	it 'has a unique license plate' do
		car = Car.create(make: 'Honda', model: 'Civic', state: 'IL', license_plate: 'AGY3559')
		expect(car.errors.messages[:license_plate]).to include('has already been taken')
	end
end

describe RentalCar do
	it 'belongs to a user' do
		rental_car = RentalCar.create()
		expect(rental_car).to respond_to :customer
	end
end
