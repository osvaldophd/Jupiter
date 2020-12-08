import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { TokenService } from 'src/app/services/token.service';
import { Router } from '@angular/router';
import { ProfileService } from './services/profile.service';
import { Profile } from './profile.modul';
import { environment } from './../../../environments/environment';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  me: Profile;
  data: any;

  img = environment.API_PATH + 'uploads/funcionarios/';

  constructor(
    private auth: AuthService,
    private token: TokenService,
    private route: Router,
    private profileService: ProfileService
  ) { }

  ngOnInit() {
    this.profileService.getAll()
      .subscribe((res: any) => {

        this.me = res;
      });

    this.data = localStorage.getItem('boleia-app-data');



  }

  logout() {
    this.auth.logout();
    if (!this.token.verifyToken()) {
      this.route.navigate(['/login']);
    }
  }

}
