#include <algorithm>
#include <atomic>
#include <deque>
#include <string>
#include <vector>
#include <sstream>

#include "test_utils.h"
#include "barrier.h"
//#include "ya_contest_sim.h"

namespace BarrierTests {

#if defined(dump_field)
#   error "already defined"
#else
#   define dump_field(field) out << (#field) << "=" << (field)
#endif

    struct TestBarrierOpts {
        size_t n_workers = 10;
        size_t n_steps = 10000;

        std::string to_string() const {
            std::ostringstream out;
            dump_field(n_workers) << ", ";
            dump_field(n_steps);
            return out.str();
        }
    };

    std::vector<size_t> prepare_test(size_t items) {
        std::vector<size_t> results(items);
        for (size_t i = 0, sz = results.size(); i < sz; ++i) {
            results[i] = i;
        }
        return results;
    }

    void validate_test(const std::vector<size_t>& results, size_t steps) {
        steps %= results.size();

        auto reverse_steps = results.size() -  steps;
        std::cout << "[";
        for (size_t i = 0, sz = results.size(); i < sz; ++i) {
            if (i == steps) {
                std::cout << "> ";
            } else if (i) {
                std::cout << ", ";
            }

            std::cout << results[i];
        }
        std::cout << "]" << std::endl;

        for (size_t i = 0, sz = results.size(); i < sz; ++i) {
            auto expected = (i + reverse_steps) % results.size();
            test_assert(results[i] == expected, "invalid result at i=" << i << ": " << results[i] << " != " << expected);
        }
    }

    void do_test_barrier(const TestBarrierOpts& opts) {
        std::cout << "Testing with parameters: " << opts.to_string() << std::endl;

        std::vector<std::thread> threads;
        auto test = prepare_test(opts.n_workers);

        barrier bar{opts.n_workers};

        std::cout << "Running workers ... " << std::endl;
        for (size_t i = 0; i < opts.n_workers; ++i) {
            threads.emplace_back([i, &bar, &test, &opts] {
                for (size_t s = 0; s < opts.n_steps; ++s) {
                    auto a = test.at(i);
                    bar.enter();
                    test.at((i + 1) % opts.n_workers) = a;
                    bar.enter();
                }
            });
        }
        std::cout << "Done" << std::endl;

        std::cout << "Joining workers ... " << std::endl;
        for (auto& t : threads) {
            if (t.joinable()) {
                t.join();
            }
        }
        std::cout << "Done" << std::endl;

        std::cout << "Validating results ... " << std::endl;
        validate_test(test, opts.n_steps);
        std::cout << "Done" << std::endl;
        std::cout << "OK" << std::endl;
    }

    void run_barrier_tests(int argc, char* argv[]) {
        TestBarrierOpts opts;
        read_opts(argc, argv, opts.n_workers, opts.n_steps);
        do_test_barrier(opts);
    }
}

int main(int argc, char* argv[]) {
    BarrierTests::run_barrier_tests(argc, argv);
}
