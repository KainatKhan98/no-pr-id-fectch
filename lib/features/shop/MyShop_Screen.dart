import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'ProductDetailScreen.dart';

class MyShopScreen extends StatefulWidget {
  const MyShopScreen({super.key});

  @override
  _MyShopScreenState createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  String _searchText = '';
  String _selectedCategory = 'All Products'; // Default category

  // Function to fetch products based on category and search query
  Stream<QuerySnapshot> getProductsByCategory(String category) {
    if (category == 'All Products') {
      return FirebaseFirestore.instance.collection('products').snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('products')
          .where('category', isEqualTo: category)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: logoPurple,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Shop", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Column(
            children: [ // Adjust the height as needed
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchText = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: const BorderSide(
                        color: textColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: const BorderSide(
                        color: textColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: const BorderSide(
                        color: textColor,
                        width: 1.5,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ]
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            // Categories List
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryButton('All Products'), // Updated category
                  _buildCategoryButton('Pet Food'),
                  _buildCategoryButton('Accessories'),
                  _buildCategoryButton('Clothing'),
                  _buildCategoryButton('Hygiene & Grooming Tools'),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // StreamBuilder for Products
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getProductsByCategory(_selectedCategory),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }

                  // Filter products based on search text
                  final filteredProducts = snapshot.data!.docs.where((product) {
                    return product['title']
                        .toString()
                        .toLowerCase()
                        .contains(_searchText);
                  }).toList();
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        childAspectRatio: 0.8, // Adjust as needed
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        var productData = filteredProducts[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to ProductDetailScreen on tap
                            Get.to(() => ProductDetailScreen(
                              productId: productData.id,
                              title: productData['title'],
                              price: productData['price'],
                              description: productData['description'],
                              imageUrl: productData['imageUrl'],
                              vendorId: productData['vendorId'],
                            ));
                          },
                          child: SizedBox(
                            height: 200,
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.network(
                                      productData['imageUrl'],
                                      height: screenHeight * 0.12, // Adjusted height
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Title
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      productData['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black, // Changed color to black for visibility
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center, // Center align title
                                    ),
                                  ),
                                  const SizedBox(height: 8), // Space between title and price

                                  // Price
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'RS: ${productData['price'].toString()}',
                                          style: const TextStyle(color: Colors.redAccent),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _selectedCategory == category ? logoPurple: logoPurple.withOpacity(0.1),
        ),
        child: Center(child: Text(category)),
      ),
    );
  }
}
