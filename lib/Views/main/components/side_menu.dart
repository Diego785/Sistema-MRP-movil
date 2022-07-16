import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_mrp/Views/Login/login.dart';
import 'package:sistema_mrp/Views/Dashboard/welcome.dart';
import 'package:sistema_mrp/Controllers/Login/auth.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer<Auth>(builder: (context, auth, child) {
      if (!auth.authenticated) {
        return ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("User"),
              accountEmail: Text("Loguearse para ver más."),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/images/user.jpg",),
                radius: 30,
                /*child: ClipOval(
                  child: Image.network(
                    "https://scontent.fvvi1-2.fna.fbcdn.net/v/t39.30808-6/240098961_2009137825918274_2290242819894292169_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=Iyl09tHdGAEAX_pkOsu&_nc_oc=AQmbtlEa3qu0vja0zjjptnNUmJA-h1y1jJBv1xhJAaf8G8JL3bogQxGaMbGMx3wTjXQClVbz5RcQWPVDixg4ilz1&_nc_ht=scontent.fvvi1-2.fna&oh=00_AT9bPTulBMOTEqxw-GlClcHvJwudcsu3oig43uHGat-6HA&oe=62100A98",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),*/
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBY6oRxyC_aIOuQgILXG0P3qlK6cH3x2AuFsHsXKMhWT19C0hpO5etVaMOUrjQkaTeO3Y&usqp=CAU"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      } else {
        return ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(auth.user.name),
              accountEmail: Text(auth.user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(auth.user.avatar),
                radius: 30,
                /*child: ClipOval(
                  child: Image.network(
                    "https://scontent.fvvi1-2.fna.fbcdn.net/v/t39.30808-6/240098961_2009137825918274_2290242819894292169_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=Iyl09tHdGAEAX_pkOsu&_nc_oc=AQmbtlEa3qu0vja0zjjptnNUmJA-h1y1jJBv1xhJAaf8G8JL3bogQxGaMbGMx3wTjXQClVbz5RcQWPVDixg4ilz1&_nc_ht=scontent.fvvi1-2.fna&oh=00_AT9bPTulBMOTEqxw-GlClcHvJwudcsu3oig43uHGat-6HA&oe=62100A98",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),*/
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBY6oRxyC_aIOuQgILXG0P3qlK6cH3x2AuFsHsXKMhWT19C0hpO5etVaMOUrjQkaTeO3Y&usqp=CAU"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Inicio"),
              onTap: () => Navigator.pushNamed(context, "/main-screen"),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.work),
              title: Text("Materia Prima"),
              onTap: () => Navigator.pushNamed(context, "/materia-prima"),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.production_quantity_limits),
              title: const Text("Productos"),
              onTap: () => Navigator.pushNamed(context, "/producto"),
            ),
            const Divider(),

             ListTile(
            leading: Icon(Icons.upcoming),
              title: const Text("Pedidos"),
              onTap: () => Navigator.pushNamed(context, "/pedido"),
            ),
            const Divider(),
             ListTile(
            leading: Icon(Icons.upcoming),
              title: const Text("Nota de Compras"),
              onTap: () => Navigator.pushNamed(context, "/nota-compra"),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text("Reportes"),
              onTap: () =>  Navigator.pushNamed(context, "/reportes"),
            ),
            const Divider(),
            /*  ListTile(
              leading: Icon(Icons.share),
              title: Text("Share"),
              onTap: () => null,
              trailing: ClipOval(
                child: Container(
                  color: Colors.red,
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      '8',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),*/
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
            ),
          ],
        );
      }
    }));

    /*Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Transaction",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Task",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Documents",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Store",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );*/
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}

void _materia_prima(BuildContext context) {
  Navigator.of(context).pushNamed("/materia-prima");
}
void _pedido(BuildContext context) {
  Navigator.of(context).pushNamed("/materia-prima");
}
