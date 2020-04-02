# Governing Equations
## Momentum
#### u direction
$$ \frac{\delta u}{\delta t} = -u\frac{\delta u}{\delta x} -\nu\frac{\delta u}{\delta y} -w\frac{\delta u}{\delta z} + \frac{u\nu tan\psi}{a} - \frac{uw}{a} - \frac{1}{\rho}\frac{\delta P}{\delta x} + 2\Omega\nu sin\psi - 2\Omega wcos\psi - \frac{\delta\bar{u'u'}}{\delta x} - \frac{\delta\bar{u'\nu '}}{\delta y} - \frac{\delta\bar{u'w'}}{\delta z} + \gamma[\frac{\delta ^{2}u}{\delta x^{2}} + \frac{\delta ^{2}u}{\delta y^{2}} + \frac{\delta ^{2}u}{\delta z^{2}}]  $$
#### v direction
$$ \frac{\delta \nu}{\delta t} = -u\frac{\delta \nu}{\delta x} -\nu\frac{\delta \nu}{\delta y} -w\frac{\delta \nu}{\delta z} + \frac{u^{2} tan\psi}{a} - \frac{\nu w}{a} - \frac{1}{\rho}\frac{\delta P}{\delta y} + 2\Omega usin\psi - \frac{\delta\bar{u'\nu '}}{\delta x} - \frac{\delta\bar{\nu '\nu '}}{\delta y} - \frac{\delta\bar{\nu 'w'}}{\delta z} + \gamma[\frac{\delta ^{2}\nu}{\delta x^{2}} + \frac{\delta ^{2}\nu}{\delta y^{2}} + \frac{\delta ^{2}\nu}{\delta z^{2}}]  $$

#### z direction
$$ \frac{\delta w}{\delta t} = -u\frac{\delta w}{\delta x} -\nu\frac{\delta w}{\delta y} -w\frac{\delta w}{\delta z} - \frac{u^{2}+\nu ^{2}}{a} - \frac{1}{\rho}\frac{\delta P}{\delta z} -g - \frac{\delta\bar{w'u'}}{\delta x} - \frac{\delta\bar{w'\nu '}}{\delta y} - \frac{\delta\bar{w'w'}}{\delta z} + \gamma[\frac{\delta ^{2}w}{\delta x^{2}} + \frac{\delta ^{2}w}{\delta y^{2}} + \frac{\delta ^{2}w}{\delta z^{2}}]  $$

## Heat
$$ \frac{\delta T}{\delta t} = -u\frac{\delta T}{\delta x} -\nu\frac{\delta T}{\delta y} -w[\frac{\delta T}{\delta z} + \Gamma _{d}] - \frac{1}{\rho C _{p}}[\frac{\delta F _{rad,x}}{\delta x} + \frac{\delta F _{rad,y}}{\delta y} + \frac{\delta F _{rad,z}}{\delta z}] + \frac{Lv}{C _{p}}\frac{\delta r _{condense}}{\delta t} - \frac{\delta\bar{T'u'}}{\delta x} - \frac{\delta\bar{T'\nu '}}{\delta y} - \frac{\delta\bar{T'w'}}{\delta z} + \nu _{\theta}[\frac{\delta ^{2}T}{\delta x^{2}} + \frac{\delta ^{2}T}{\delta y^{2}} + \frac{\delta ^{2}T}{\delta z^{2}}] $$

## Moisture
$$ \frac{\delta r _{T}}{\delta t} = -u\frac{\delta r _{T}}{\delta x} -\nu\frac{\delta r _{T}}{\delta y} -w\frac{\delta r _{T}}{\delta z} - \frac{\rho _{L}}{\rho _{d}}\frac{\delta Precip}{\delta z} - \frac{\delta\bar{r _{T}'u'}}{\delta x} - \frac{\delta\bar{r _{T}'\nu '}}{\delta y} - \frac{\delta\bar{r _{T}'w'}}{\delta z} + \gamma[\frac{\delta ^{2}r _{T}}{\delta x^{2}} + \frac{\delta ^{2}r _{T}}{\delta y^{2}} + \frac{\delta ^{2}r _{T}}{\delta z^{2}}] $$ 

## Mass
$$ \frac{\delta \rho}{\delta t} = -u\frac{\delta \rho}{\delta x} -\nu\frac{\delta \rho}{\delta y} -w\frac{\delta \rho}{\delta z} - \rho[\frac{\delta u}{\delta x} + \frac{\delta \nu}{\delta y} + \frac{\delta w}{\delta z}] $$

## Equation of State
$$ p = \rho RT $$ where R is the gas constant for humid air
$$ P = \rho R _{d}T _{\nu} $$
where, 

$$ R_{d} = 287 K/kg $$
$$ T_{\nu} = T(1 + 0.61r - r_{L} -r_{i}) $$

# Forecast Verification
## Mean Squared Error
$$ MSE = \frac{1}{n}\sum_{i=1}^n (Y _{i} - Y _{obs})^{2} $$

## Mean Absolute Error
$$ MAE = \frac{1}{n}\sum_{i=1}^n |{Y _{i} - Y _{obs}}| $$

## Standard Deviation
$$ \sigma = \sqrt{\frac{\sum_{i=1}^n ({Y _{i} - Y _{obs}})^{2}}{N}} $$

## Mean Absolute Error Skill Skore
$$ MAESS = 1 - \frac{MAE_{Forecast_A}}{MAE_{Forecast_B}} $$

# WRF setup
## Possible physics schemes
        mp_physics:      8, 8, 4, 4, 8
        cu_physics:      6, 1, 1, 1, 3
     ra_lw_physics:      4, 1, 1, 1, 1
     ra_sw_physics:      4, 1, 1, 1, 1
    bl_pbl_physics:      2, 7, 1, 12, 1
 sf_sfclay_physics:      2, 1, 1, 1, 1
sf_surface_physics:      2, 4, 4, 4, 4
