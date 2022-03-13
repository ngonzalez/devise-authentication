import RegisterUser from '../views/users/register.vue';
import SignInUser from '../views/users/sign_in.vue';
import EditUser from '../views/users/edit.vue';
import HomeShow from '../views/home/show.vue';

let routes = [
  {
    path: '/home',
    name: 'home',
    component: HomeShow,
  },
  {
    path: '',
    name: 'sign_in',
    component: SignInUser,
  },
  {
    path: '/sign_up',
    name: 'sign_up',
    component: RegisterUser,
  },
  {
    path: '/edit_user',
    name: 'edit_user',
    component: EditUser,
  },
];

export default routes;
