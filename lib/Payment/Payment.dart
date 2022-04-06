class Payment {
  final String id;
  final String dob;
  final String nic;
  final String cardname;

  final String bank;
  final int cardnumber;
  final int cvc;
  final String address;

  final double price;

  // final String fname;
  // final String lname;
  // final String username;
  // final String password;
  // final String cPassword;

  // User(this.fname, this.lname, this.username, this.password, this.cPassword);
  Payment(this.id, this.dob, this.nic, this.cardname, 
      this.bank,   this.cvc,this.price,this.cardnumber,this.address);
}
