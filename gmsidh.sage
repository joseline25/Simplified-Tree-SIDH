from functools import reduce
import operator
import random
import time

prime = {3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997, 1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097, 1103, 1109, 1117, 1123, 1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213, 1217, 1223, 1229, 1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297, 1301, 1303, 1307, 1319, 1321, 1327, 1361, 1367, 1373, 1381, 1399, 1409, 1423, 1427, 1429, 1433, 1439, 1447, 1451, 1453, 1459, 1471, 1481, 1483, 1487, 1489, 1493, 1499, 1511, 1523, 1531, 1543, 1549, 1553, 1559, 1567, 1571, 1579, 1583, 1597, 1601, 1607, 1609, 1613, 1619, 1621, 1627, 1637, 1657, 1663, 1667, 1669, 1693, 1697, 1699, 1709, 1721, 1723, 1733, 1741, 1747, 1753, 1759, 1777, 1783, 1787, 1789, 1801, 1811, 1823, 1831, 1847, 1861, 1867, 1871, 1873, 1877, 1879, 1889, 1901, 1907, 1913, 1931, 1933, 1949, 1951, 1973, 1979, 1987, 1993, 1997, 1999, 2003, 2011, 2017, 2027, 2029, 2039, 2053, 2063, 2069, 2081, 2083, 2087, 2089, 2099, 2111, 2113, 2129, 2131, 2137, 2141, 2143, 2153, 2161, 2179, 2203, 2207, 2213, 2221, 2237, 2239, 2243, 2251, 2267, 2269, 2273, 2281, 2287, 2293, 2297, 2309, 2311, 2333, 2339, 2341, 2347, 2351, 2357, 2371, 2377, 2381, 2383, 2389, 2393, 2399, 2411, 2417, 2423, 2437, 2441, 2447, 2459, 2467, 2473, 2477, 2503, 2521, 2531, 2539, 2543, 2549, 2551, 2557, 2579, 2591, 2593, 2609, 2617, 2621, 2633, 2647, 2657, 2659, 2663, 2671, 2677, 2683, 2687, 2689, 2693, 2699, 2707, 2711, 2713, 2719, 2729, 2731, 2741, 2749, 2753, 2767, 2777, 2789, 2791, 2797, 2801, 2803, 2819, 2833, 2837, 2843, 2851, 2857, 2861, 2879, 2887, 2897, 2903, 2909, 2917, 2927, 2939, 2953, 2957, 2963, 2969, 2971, 2999, 3001, 3011, 3019, 3023, 3037, 3041, 3049, 3061, 3067, 3079, 3083, 3089, 3109, 3119, 3121, 3137, 3163, 3167, 3169, 3181, 3187, 3191, 3203, 3209, 3217, 3221, 3229, 3251, 3253, 3257, 3259, 3271, 3299, 3301, 3307, 3313, 3319, 3323, 3329, 3331, 3343, 3347, 3359, 3361, 3371, 3373, 3389, 3391, 3407, 3413, 3433, 3449, 3457, 3461, 3463, 3467, 3469, 3491, 3499, 3511, 3517, 3527, 3529, 3533, 3539, 3541, 3547, 3557, 3559, 3571, 3581, 3583, 3593, 3607, 3613, 3617, 3623, 3631, 3637, 3643, 3659, 3671, 3673, 3677, 3691, 3697, 3701, 3709, 3719, 3727, 3733, 3739, 3761, 3767, 3769, 3779, 3793, 3797, 3803, 3821, 3823, 3833, 3847, 3851, 3853, 3863, 3877, 3881, 3889, 3907, 3911, 3917, 3919, 3923, 3929, 3931, 3943, 3947, 3967, 3989, 4001, 4003, 4007, 4013, 4019, 4021, 4027, 4049, 4051, 4057, 4073, 4079, 4091, 4093, 4099, 4111, 4127, 4129, 4133, 4139, 4153, 4157, 6701};

# restrict to a smaller set
prime = sorted(prime)[:32]

primes_list = sorted(prime)

odd_index_primes = []
even_index_primes = []


for i, prime in enumerate(primes_list):
    if i % 2 == 0:
        even_index_primes.append(prime)
    else:
        odd_index_primes.append(prime)
        
        


# Function to compute the product of all numbers in a list
def product_of_list(lst):
    return reduce(operator.mul, lst, 1)

A = 61790323281691893111408549
B = 583002433097459956230657095

f = 15
p = 2161434528906300014570338085967612962021511076230309299

# calcul du corps de base de la courbe
F.<i> = GF(p^2, modulus = x^2 + 1)
E = EllipticCurve(F, [0,1])

# random point P of order == order
def get_rand_point_ord(order, E, ord_oth):
    P = E.random_point()
    P_prime = (ord_oth * 4) ** 2 * P
    while P_prime.order() != order:
        P = E.random_point()
        P_prime = (ord_oth * 4) ** 2 * P
    return P_prime

# generate a torsion basis 
def get_random_base(order, E, ord_oth):
    P = get_rand_point_ord(order, E, ord_oth)
    Q = get_rand_point_ord(order, E, ord_oth)
    while P.weil_pairing(Q, order).multiplicative_order() != order:
        Q = get_rand_point_ord(order, E, ord_oth)
    return P, Q

PA, QA = get_random_base(A, E, B)
PB, QB = get_random_base(B, E, A)

# params A for 2i+1 and B for 2i+2

params = {}
params['A'] = [PA, QA, A]
params['B'] = [PB, QB, B]
def get_other(name):
    if name == 'A':
        return params['B']
    elif name == 'B':
        return params['A']
    
# Function to update params['A']
def update_params_A(A, E, B, params):
    PA, QA = get_random_base(A, E, B)
    params['A'] = [PA, QA, A]
    
# Function to update params['B']
def update_params_B(B, E, A, params):
    PB, QB = get_random_base(B, E, A)
    params['B'] = [PB, QB, B]
    
    
def isogeny_graph_walk(E, P, alpha, P_oth = None, Q_oth = None):
    phi = E.isogeny(P, algorithm="factored")
    if (P_oth != None and Q_oth != None):
        P_oth = alpha*phi(P_oth)
        Q_oth = alpha*phi(Q_oth)

    return (phi.codomain(),P_oth, Q_oth)


class Entity:
    def __init__(self, name):
        self.name = name
        self.P = params[name][0]
        self.Q = params[name][1]
        self.factor = params[name][2]
        
        self.sk = random.randrange(self.factor)
        self.S = self.P + self.sk * self.Q
        
        other = get_other(self.name)
        ring_other = Integers(other[2])
        self.alpha = Integer(random.choice(ring_other(1).nth_root(2, all=True)))
        assert self.factor == self.S.order()
        self.pk = self.gen_pub_key(get_other(self.name))
        
        
    def gen_pub_key(self, other):
        return isogeny_graph_walk(E, self.S, self.alpha, other[0], other[1])
    
    def gen_shared_key(self, peer):
        S = peer.pk[1] + self.sk * peer.pk[2]
        shared_curve, _, _ = isogeny_graph_walk(peer.pk[0], S, self.alpha)
        return shared_curve.j_invariant()
    

t0 = time.perf_counter()
print('Started generation of PKA')
A = Entity('A')

print('Started generation of PKB')
B = Entity('B')
print('Started generation of secA')

secA = A.gen_shared_key(B)
print('Started generation of secB')
secB = B.gen_shared_key(A)

t1 = time.perf_counter()
assert secA == secB
print("Time elapsed (s):", t1 - t0)

# progression in the tree

def binary_representation(element, p):
    coefficients = element.polynomial().coefficients()
    binary_representation = ''.join([bin(int(coeff))[2:].zfill(p.bit_length()) for coeff in coefficients])
    return binary_representation

def binary_to_finite_field_element(binary_str, p, F):
    bit_length = p.bit_length()
    num_coefficients = 2  # Assuming x^2 + 1 has two coefficients
    coefficients = [int(binary_str[i*bit_length:(i+1)*bit_length], 2) for i in range(num_coefficients)]
    element = sum(F(coeff) * (F.gen()^n) for n, coeff in enumerate(coefficients))
    return element

def xor_binary_strings(bin_str1, bin_str2):
    max_len = max(len(bin_str1), len(bin_str2))
    bin_str1 = bin_str1.zfill(max_len)
    bin_str2 = bin_str2.zfill(max_len)
    xor_result = ''.join('1' if b1 != b2 else '0' for b1, b2 in zip(bin_str1, bin_str2))
    return xor_result

def field_elements_xor(element1, element2, p, F):
    # Convert field elements to binary
    bin_str1 = binary_representation(element1, p)
    bin_str2 = binary_representation(element2, p)
    
    # Perform XOR on binary representations
    xor_result = xor_binary_strings(bin_str1, bin_str2)
    
    # Convert XOR result back to a finite field element
    xor_element = binary_to_finite_field_element(xor_result, p, F)
    
    return xor_element

xor_element = field_elements_xor(secA, secB, p, F)
print("XOR result as finite field element:", xor_element)

# create the binary tree

# Create a node
class Node:
    def __init__(self, value):
        self.left = None
        self.right = None
        self.value = value

# Create a complete binary tree
def create_complete_binary_tree(num_leaves):
    if num_leaves == 0:
        return None
    # Calculate the total number of nodes
    total_nodes = 2 * num_leaves - 1
    # Create the nodes
    nodes = [Node(i) for i in range(total_nodes)]
    # Link the nodes to form a complete binary tree
    for i in range(total_nodes // 2):
        if 2 * i + 1 < total_nodes:  # Ensure left child index is within bounds
            nodes[i].left = nodes[2 * i + 1]
        if 2 * i + 2 < total_nodes:  # Ensure right child index is within bounds
            nodes[i].right = nodes[2 * i + 2]
    return nodes[0]

def print_tree(node, level=0):
    if node is not None:
        print_tree(node.right, level + 1)
        print(' ' * 4 * level + '->', node.value)
        print_tree(node.left, level + 1)

def collect_intermediary_leaves(node):
    if not node:
        return {}
    
    leaves_dict = {}
    
    def traverse_and_collect(node, leaves_collected):
        if not node:
            return []

        # Collect leaves from left and right children
        left_leaves = traverse_and_collect(node.left, leaves_collected)
        right_leaves = traverse_and_collect(node.right, leaves_collected)

        # Combine leaves collected from both children
        all_leaves = left_leaves + right_leaves

        if node.left or node.right:
            # Update the dictionary for the current node with leaves from its subtree
            leaves_dict[node.value] = all_leaves.copy()

        # If it's a leaf node, add to the list of leaves collected
        if not node.left and not node.right:
            all_leaves = [node.value]

        # Return all leaves collected so far
        return all_leaves

    traverse_and_collect(node, [])
    return leaves_dict



def get_positive_integer(prompt="Enter a positive integer: "):
    while True:
        try:
            value = int(input(prompt))
            if value > 0:
                return value
            else:
                print("The number must be positive. Please try again.")
        except ValueError:
            print("Invalid input. Please enter a valid integer.")

#  usage
positive_integer = get_positive_integer()
print(f"You entered: {positive_integer}")
num_leaves = 7
root = create_complete_binary_tree(positive_integer)
print_tree(root)

# Get the dictionary of intermediary nodes to list of leaves at each level
intermediary_leaves_dict = collect_intermediary_leaves(root)
for key, value in intermediary_leaves_dict.items():
    print(f"Node {key}: {value}")
total_num_level = len(levels)


def create_pairs(numbers):
    pairs = []
    # Iterate over the list in steps of 2
    for i in range(Integer(0), len(numbers) - 1, Integer(2)):
        # Create a tuple of the current element and the next element
        pair = (numbers[i], numbers[i + Integer(1)])
        # Add the tuple to the pairs list
        pairs.append(pair)
    return pairs


"""
-  take the level we are currently in the tree
- - get all the nodes at that level
- for each node, find the list of all leaves descendants
- each leaves choose k_i and alpha_i in the appropriate set
- perform the xor with the previous secret at previous level and share it with the leaves under the node at that level
- compute k, alpha then perform the key exchange


- create the tree first, 
- get the number of level, 
- start at the lowest level
"""

for level in range(total_num_level,0,-1):
    # level 
    print("level:", level)
    # all nodes at that level 
    all_nodes_level = levels[level-1]
    print("all nodes at that level:", all_nodes_level)
    # create pairs
    pairs = create_pairs(all_nodes_level)
    print("all pairs of nodes at that level:", pairs)
    # leaves nodes 
    leave_nodes = leaves_by_level[level-1]
    print("all leaves at that level:", leave_nodes)
    # intermediary nodes
    intermediary_nodes = unique_elements(all_nodes_level, leave_nodes)
    print("all intermediary node at that level:", intermediary_nodes)
    # dict of intermediary nodes and the descendant leaves
    intermediary_leaves_dict = collect_intermediary_leaves(root)
    for key, value in intermediary_leaves_dict.items():
        if key in intermediary_nodes:
            print(f"Node {key}: {value}")
    # manage the key exchange
    for pair in pairs:
        pair_keys = {}
        for node in pair:
            if node in leave_nodes:
                print(f"Node {node} in pair {pair} is a leaf.")
                if node % 2 == 1:
                    pair_keys[node] = Entity('A')
                else:
                    pair_keys[node] = Entity('B')   
            else:
                print(f"Node {node} in pair {pair} is an intermediary node.")
                # special treatment for intermediary nodes
            print('Started generation of secA')
            secA = A.gen_shared_key(B)
            print('Started generation of secB')
            secB = B.gen_shared_key(A)
            assert secA == secB
            print(secA)
