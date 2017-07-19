
program inversion !this code gives you the number of inversions of the eigen after m steps
!My idea for quantifying the inversion is based on the fact that if the oxygen is found on one side at the first instant
!and the dot product with the axis is =+ve and at the next instance it is negative then an  inversion has occured


implicit none
integer :: i, m, t = 0
real, dimension(3) :: h1, h2, h3,h4,h5,o1, o2, orthoH1toH3, h2toh1, orthoh1toh5, H4toh1
real :: s1,s2, bondlengthdifference
character (LEN=1) :: skipacharacter
integer :: inversioncounter1, inversioncounter2
real, dimension(3) :: REFAXIS1,REFAXIS2, averagevector1, averagevector2
integer, allocatable :: side1(:),side2(:)
real, dimension(40) :: counter1, counter2
character(LEN=100) :: argv, in_file, out_file!='Zundel_000.dat'

	!write(*,*)'Please input the number of steps. You can find that in the xyz file'
	!read(*,*)m
	m = 40000
	allocate(side1(m))
	allocate(side2(m))

	call GETARG(1,argv)	
	in_file = trim(argv)
	print *, in_file
    
    out_file = in_file(28:31)
	open(unit =1 ,file=in_file ,status = 'old', action = 'read')

	!opening xyz file
    call system('mkdir -p output/inv1')
    out_file = 'output/inv1/'//'Zundel-'//trim(out_file)//'dat'
	Open(unit=10, Status='replace', file=out_file, action='write')
	!Open(unit=10, Status='replace', file='inversionvsbondlength.txt', action='write')

	counter1 = 0.0
	counter2 = 0.0
	inversioncounter1=0
	inversioncounter2=0
	side1= 0
	side2= 0

	do i=1, m

	t=t+1

	read(1,*)
	read(1,*)
	read(1,*)skipacharacter,o1
	read(1,*)skipacharacter,o2
	read(1,*)skipacharacter,h1
	read(1,*)skipacharacter,h2
	read(1,*)skipacharacter,h3
	read(1,*)skipacharacter,h4
	read(1,*)skipacharacter,h5

	averagevector1 = (H1+H2+h3-3.0*o1)/3.0
	averagevector2 = (H1+h4+h5-3.0*o2)/3.0

	h2toh1 = h2 - h1
	h2toh1 = h2toh1/(sqrt(dot_product(h2toh1,h2toh1)))

	h4toh1 = h4 - h1
	h4toh1 = h4toh1/(sqrt(dot_product(h4toh1,h4toh1)))


	!using the gram-schmidt procedure to get orthoh1toh3(a vector perpendicular to h2toh1)
	orthoH1toH3 = (h3-h1) - ((dot_product(h3-h1,h2toh1))*(h2toh1))/((h2toh1(1)**2  + h2toh1(2)**2 + h2toh1(3)**2))
	orthoH1toH3= orthoH1toH3/(sqrt(dot_product(orthoH1toH3,orthoH1toH3)))
	!finding the vector perpendicular to it using the crossproduct of orthoH1toH3 with h2toH1
	REFAXIS1(1) = orthoH1toH3(2)*h2toh1(3) - orthoH1toH3(3)*h2toh1(2)
	REFAXIS1(2) = orthoH1toH3(3)*h2toh1(1) - orthoH1toH3(1)*h2toh1(3)
	REFAXIS1(3) = orthoH1toH3(1)*h2toh1(2) - orthoH1toH3(2)*h2toh1(1)

	s1 = dot_product(averagevector1,REFAXIS1)


	!using the gram-schmidt procedure to get orthoh1toh3(a vector perpendicular to h2toh1)
	orthoH1toH5 = (h5-h1) - ((dot_product(h5-h1,h4toh1))*(h4toh1))/((h4toh1(1)**2  + h4toh1(2)**2 + h4toh1(3)**2))
	orthoH1toH5= orthoH1toH5/(sqrt(dot_product(orthoH1toH5,orthoH1toH5)))
	!finding the vector perpendicular to it using the crossproduct of orthoH1toH3 with h2toH1
	REFAXIS2(1) = orthoH1toH5(2)*h4toh1(3) - orthoH1toH5(3)*h4toh1(2)
	REFAXIS2(2) = orthoH1toH5(3)*h4toh1(1) - orthoH1toH5(1)*h4toh1(3)
	REFAXIS2(3) = orthoH1toH5(1)*h4toh1(2) - orthoH1toH5(2)*h4toh1(1)

	s2 = dot_product(averagevector2,REFAXIS2)

	bondlengthdifference = sqrt(dot_product(o2-h1,o2-h1))- sqrt(dot_product(o1-h1,o1-h1))

	!write(*,*)'h1',sqrt(dot_product(o2-h1,o2-h1)), sqrt(dot_product(o1-h1,o2-h1))
	!write(*,*)'h2',sqrt(dot_product(o2-h2,o2-h2)), sqrt(dot_product(o1-h2,o2-h2))
	!write(*,*)'h3',sqrt(dot_product(o2-h3,o2-h3)), sqrt(dot_product(o1-h3,o1-h3))
	!write(*,*)'h4',sqrt(dot_product(o2-h4,o2-h4)), sqrt(dot_product(o1-h4,o1-h4))
	!write(*,*)'h5',sqrt(dot_product(o2-h5,o2-h5)),sqrt(dot_product(o1-h5,o1-h5)) 

	write(10,*)s1,s2,bondlengthdifference

	end do

end program inversion
