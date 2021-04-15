import NavbarBottomList from './navbar-mobile/bottom-list';
import NavbarLogo from './navbar-mobile/logo';
import NavbarMobileTopList from './navbar-mobile/top-list';
import useScrollPosition from '@react-hook/window-scroll';
let previousScroll; let scrolledUp;

export default function NavbarMobile({logoUrl}) {
  const scrollY = useScrollPosition(60);
  scrolledUp = previousScroll && previousScroll > scrollY;
  previousScroll = scrollY;

  return (
    <div className="navbar fixed top-0 left-0 right-0">
      {
        (scrollY < 100 || scrolledUp) &&
        <div className="flex justify-between items-center px-2 pt-2">
          <NavbarLogo logoUrl={logoUrl}/>

          <div>
            <NavbarMobileTopList/>
          </div>
        </div>
      }

      <div className="pt-6 px-8 border-b border-solid border-gray-400 pb-2">
        <NavbarBottomList/>
      </div>
    </div>
  );
}
