export class User {
  id: number;
  email: string;
  username: string;
  password: string;
  createDate: Date;
  lastLogin: Date;
  enabled: boolean;
  role: string;
  sponsor: boolean;
  firstName: string;
  lastName: string;
  imgUrl: string;
  bio: string;
  // address: Address;
  // originCountry: Country;

  constructor(
    id: number = 0,
    email: string = '',
    username: string = '',
    password: string = '',
    createDate: Date = new Date(),
    lastLogin: Date = new Date(),
    enabled: boolean = true,
    role: string = '',
    sponsor: boolean = false,
    firstName: string = '',
    lastName: string = '',
    imgUrl: string = '',
    bio: string = ''
  ) {
    this.id = id;
    this.email = email;
    this.username = username;
    this.password = password;
    this.createDate = createDate;
    this.lastLogin = lastLogin;
    this.enabled = enabled;
    this.role = role;
    this.sponsor = sponsor;
    this.firstName = firstName;
    this.lastName = lastName;
    this.imgUrl = imgUrl;
    this.bio = bio;
  }
}
