#ifndef BARRIER_H
#define BARRIER_H

#include <atomic>
#include <mutex>
#include <array>
#include <thread>
#include <condition_variable>
#include <iostream>

using std::size_t;
using std::condition_variable;
using std::mutex;
using std::unique_lock;
using std::atomic;

using std::cin;
using std::cout;
using std::endl;

using std::thread;

class barrier
{
public:
    explicit barrier(size_t num_threads);
    void enter();
private:
    mutex mtx_in;
    mutex mtx_out;

    atomic<int> outDoor;
    size_t counter;
    size_t max_threads;


    condition_variable cv_out;
    condition_variable cv_in;

    void clear_counter();
};

barrier::barrier(size_t num_threads) :
    max_threads(num_threads)
{
    clear_counter();
    outDoor.store(0);
}

void barrier::enter()
{
  
    // ---------------------------------------

    unique_lock<mutex> lock_in(mtx_in);
  cout << (std::this_thread::get_id()) << " : " << "ENTERING..." << endl;
    while (outDoor.load() > 0)
    {
        cout << (std::this_thread::get_id()) << " : " << "waiting outDoor..." << endl;
        cv_in.wait(lock_in);
    }
    //lock_in.unlock();

    // ---------------------------------------

    //unique_lock<mutex> lock_out(mtx_out);
    ++counter;
    if (counter >= max_threads)
    {
        cout << (std::this_thread::get_id()) << " : " << "case1, counter = " << counter << "; maxth = " << max_threads << endl;
        outDoor.store(counter);
        clear_counter();
        cv_out.notify_all();
    }
    else
    {
        cout << (std::this_thread::get_id()) << " : " << "counter = " << counter <<"; maxth = "  << max_threads << endl;
        while (counter < max_threads)
        {
        cout << (std::this_thread::get_id()) << " : " << "waiting counter < maxthreads" << endl;
            cv_out.wait(lock_in);
        }
    }

    cout << (std::this_thread::get_id()) << " : " << "We are here now" << endl;
    --outDoor;
    if (outDoor == 0)
        cv_in.notify_all();

    cout << (std::this_thread::get_id()) << " : " << "SUCC. GET OUT THIS SHIT"<< endl;
    lock_in.unlock();

}

void barrier::clear_counter()
{
    counter = 0;
}

#endif

