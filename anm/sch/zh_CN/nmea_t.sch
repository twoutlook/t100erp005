/* 
================================================================================
檔案代號:nmea_t
檔案名稱:待結算卡入帳明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmea_t
(
nmeaent       number(5)      ,/* 企業編碼 */
nmeacomp       varchar2(10)      ,/* 法人 */
nmeadocno       varchar2(20)      ,/* 單據單號 */
nmeaseq       number(10,0)      ,/* 項次 */
nmeasite       varchar2(10)      ,/* 營運據點 */
nmea001       varchar2(20)      ,/* 卡號 */
nmea002       varchar2(8)      ,/* 收銀時間 */
nmea003       number(10)      ,/* 款別類型 */
nmea004       varchar2(10)      ,/* 款別 */
nmea005       varchar2(10)      ,/* 卡種 */
nmea006       varchar2(10)      ,/* 幣別 */
nmea007       varchar2(40)      ,/* POS機號 */
nmea008       varchar2(10)      ,/* 收款對象 */
nmea009       number(20,6)      ,/* 收款金額 */
nmea010       varchar2(10)      ,/* 交易對像識別碼 */
nmea011       number(20,6)      ,/* 手續費率 */
nmea012       number(20,6)      ,/* 手續費 */
nmea013       varchar2(10)      ,/* 交易帳戶 */
nmea014       varchar2(10)      ,/* 存提碼 */
nmea015       varchar2(1)      ,/* 是否回款 */
nmea016       varchar2(10)      ,/* 卡種說明 */
nmea017       varchar2(20)      ,/* 第三方流水號 */
nmea018       varchar2(1)      ,/* 對賬否 */
nmea019       date      ,/* 對帳日期 */
nmea020       date      ,/* 收款日期 */
nmeaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmeaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmeaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmeaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmeaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmeaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmeaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmeaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmeaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmeaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmeaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmeaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmeaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmeaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmeaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmeaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmeaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmeaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmeaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmeaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmeaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmeaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmeaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmeaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmeaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmeaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmeaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmeaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmeaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmeaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmea_t add constraint nmea_pk primary key (nmeaent,nmeacomp,nmeadocno,nmeaseq) enable validate;

create unique index nmea_pk on nmea_t (nmeaent,nmeacomp,nmeadocno,nmeaseq);

grant select on nmea_t to tiptop;
grant update on nmea_t to tiptop;
grant delete on nmea_t to tiptop;
grant insert on nmea_t to tiptop;

exit;
