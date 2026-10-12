import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/joke_cubit.dart';
import '../cubit/joke_state.dart';

class JokeScreen extends StatelessWidget {
  const JokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background gradient to make the frosted glass card pop!
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey.shade100, Colors.blueGrey.shade50],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: BlocBuilder<JokeCubit, JokeState>(
                builder: (context, state) {
                  if (state is JokeLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is JokeLoaded) {
                    final joke = state.joke;
                    return _buildJokeCard(context, joke);
                  } else if (state is JokeError) {
                    return _buildErrorState(context, state.message);
                  }

                  // Initial State (No joke fetched yet)
                  return _buildInitialState(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- main frosted card design ---
  Widget _buildJokeCard(BuildContext context, dynamic joke) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 380),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        // Smooth gradient for the frosted glass background
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.85),
            const Color(0xFFE0F7FA).withOpacity(0.65), // Soft pastel teal/blue
          ],
        ),
        borderRadius: BorderRadius.circular(32), // Deep rounded corners
        border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.12),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar (Mascot) & Share Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF1E293B,
                  ), // Dark slate circular background
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.psychology, // Tech/Knowledge brain mascot
                    color: Colors.cyanAccent,
                    size: 28,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {}, // Optional Share activity can be wired here
                icon: const Icon(
                  Icons.ios_share_outlined,
                  color: Colors.black54,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Metadata Tag labels
          const Text(
            'Development Joke',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Programming Category',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black45,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          // pill chip indicators
          Row(
            children: [
              _buildPillTag('Code'),
              const SizedBox(width: 8),
              _buildPillTag('Joke'),
            ],
          ),
          const SizedBox(height: 24),

          // Dynamic joke content area
          Text(
            joke.setup,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
              height: 1.4,
            ),
          ),
          if (joke.isTwoPart) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.black.withOpacity(0.06),
                    thickness: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              joke.delivery ?? '',
              style: TextStyle(
                fontSize: 17,
                color: Colors.teal.shade800,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 28),

          // Stats Sub-Row (Rating / Read / Trend)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniStat(Icons.star, '4.8', 'Rating'),
              _buildMiniStat(Icons.chat_bubble_outline, '12K+', 'Reads'),
              _buildMiniStat(Icons.trending_up, 'Active', 'Trend'),
            ],
          ),
          const SizedBox(height: 28),

          // footer buttons row: get another joke & like buttons
          Row(
            children: [
              // 'Get another joke' custom button (Left capsule)
              Expanded(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFE0F2FE).withOpacity(0.9),
                        const Color(0xFFBAE6FD).withOpacity(0.9),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.6),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<JokeCubit>().fetchJoke();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'Get another joke',
                        style: TextStyle(
                          color: Color(0xFF0369A1),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // circular "Like" button (Right circular card)
              GestureDetector(
                onTap: () {
                  // Wire bookmark/like action
                },
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.favorite_border_rounded, // Like outline heartbeat icon
                      color: Color(0xFF1E293B),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Pill visual helper tag
  Widget _buildPillTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Simple statistics metadata module
  Widget _buildMiniStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF1E293B)),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Error Card styling fallback
  Widget _buildErrorState(BuildContext context, String error) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.red.shade50.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline_rounded, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<JokeCubit>().fetchJoke(),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  // Welcome state button logic
  Widget _buildInitialState(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<JokeCubit>().fetchJoke(),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        'Fetch a Joke',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
