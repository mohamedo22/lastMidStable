import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Contact-Us/requests_screen.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/FlatAdmin/flat_admin_page.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Social_housing_admin/AddSocialHouseAdminScreen.dart';
import 'package:your_mediator/Features/Admin/Presentation/Pages/Social_housing_admin/SocialHouseAdminDetails.dart';
import 'package:your_mediator/Features/Admin/Presentation/Providers/SocialHouseAdminProvider.dart';

class SocialHouseAdminScreen extends StatefulWidget {
  static const String routeName = "SocialHouseAdminScreen";

  @override
  _SocialHouseAdminScreenState createState() => _SocialHouseAdminScreenState();
}

class _SocialHouseAdminScreenState extends State<SocialHouseAdminScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SocialHouseAdminProvider>(context, listen: false).loadSocialHouses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Social Houses')),
      body: Consumer<SocialHouseAdminProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (query) {
                    // Implement search functionality
                  },
                  decoration: InputDecoration(
                    labelText: 'Search by Title or City',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Provider.of<SocialHouseAdminProvider>(context, listen: false).loadSocialHouses();
                          },
                          child: Text("Reload Page"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AllFlatsAdminScreen.routeName);
                          },
                          child: Text("Flat"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, RequestsScreen.routeName);
                          },
                          child: Text("Contact-Us"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.socialHouses.length,
                  itemBuilder: (context, index) {
                    final socialHouse = provider.socialHouses[index];
                    return ListTile(
                      title: Text(socialHouse.title),
                      subtitle: Text(socialHouse.address),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SocialHouseAdminDetails(socialHouse: socialHouse),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete,color: Colors.red,),
                        onPressed: () async {
                          await provider.deleteSocialHouse(index); // Pass the correct ID
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddSocialHouseAdminScreen(),));
      },child: Icon(Icons.add),),
    );
  }
}
