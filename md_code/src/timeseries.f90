program inversion !this code gives you the number of inversions of the eigen after m steps
!This idea for quantifying the inversion is based on the fact that if the oxygen is found on one side at the first instant
!and the dot product with the axis is =+ve and at the next instance it is negative then an  inversion has occured


implicit none
integer :: i, m
real, dimension(3) :: h1, h2, h3, o, orthoH1toH3,  h2toh1
real :: s, t=0.0 !, binwidth = 0.05
character (LEN=1) :: skipacharacter
real, dimension(3) :: REFAXIS, averagevector
integer, allocatable :: side(:)
real, dimension(40) :: counter


	write(*,*)'Please input the number of steps. You can find that in the xyz file'
	read(*,*)m
	allocate(side(m))
	side = 0

	!opening xyz file
	open(unit = 1,file = 'H20-pos-1.xyz',status = 'old', action = 'read')
	Open(unit=10, Status='replace', file='timeseries.txt', action='write')

	counter = 0.0
	do i=1, m
		t = t + 1.0
		read(1,*)
		read(1,*)
		read(1,*)skipacharacter,O
		read(1,*)skipacharacter,h1
		read(1,*)skipacharacter,h2
		read(1,*)skipacharacter,h3

		averagevector = (H1+H2+h3-3.0*O)/3.0

		h2toh1 = h2 - h1
		h2toh1 = h2toh1/(sqrt(dot_product(h2toh1,h2toh1)))


		!using the gram-schmidt procedure to get orthoh1toh3(a vector perpendicular to h2toh1)
		orthoH1toH3 = (h3-h1) - ((dot_product(h3-h1,h2toh1))*(h2toh1))/((h2toh1(1)**2  + h2toh1(2)**2 + h2toh1(3)**2))
		orthoH1toH3= orthoH1toH3/(sqrt(dot_product(orthoH1toH3,orthoH1toH3)))
		!finding the vector perpendicular to it using the crossproduct of orthoH1toH3 with h2toH1
		REFAXIS(1) = orthoH1toH3(2)*h2toh1(3) - orthoH1toH3(3)*h2toh1(2)
		REFAXIS(2) = orthoH1toH3(3)*h2toh1(1) - orthoH1toH3(1)*h2toh1(3)
		REFAXIS(3) = orthoH1toH3(1)*h2toh1(2) - orthoH1toH3(2)*h2toh1(1)


		s = dot_product(averagevector,REFAXIS)


		write(10,*)t, s
	 

	end do 




end program inversion
