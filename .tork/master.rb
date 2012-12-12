Tork::Master.send :remove_const, :MAX_CONCURRENT_WORKERS
Tork::Master::MAX_CONCURRENT_WORKERS = 1
