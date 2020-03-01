
weekNumber = Time.now.strftime("%u").to_i;;
weekCount = Time.now.strftime("%U").to_i;;
puts(weekCount);
puts(weekCount.even?);