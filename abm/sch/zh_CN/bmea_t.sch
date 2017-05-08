/* 
================================================================================
檔案代號:bmea_t
檔案名稱:取替代料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmea_t
(
bmeaent       number(5)      ,/* 企業編號 */
bmeasite       varchar2(10)      ,/* 營運據點 */
bmea001       varchar2(40)      ,/* 主件料號 */
bmea002       varchar2(30)      ,/* 特性 */
bmea003       varchar2(40)      ,/* 元件料號 */
bmea004       varchar2(10)      ,/* 部位 */
bmea005       varchar2(10)      ,/* 作業 */
bmea006       varchar2(10)      ,/* 製程式 */
bmea007       varchar2(10)      ,/* 取代/替代 */
bmea008       varchar2(40)      ,/* 取替代料件編號 */
bmea009       date      ,/* 生效日期 */
bmea010       date      ,/* 失效日期 */
bmea011       number(20,6)      ,/* 取替代量 */
bmea012       number(20,6)      ,/* 元件底數 */
bmea013       varchar2(10)      ,/* 替代料發料單位 */
bmea014       varchar2(1)      ,/* 限定客戶 */
bmea015       number(5,0)      ,/* 優先順序 */
bmea016       varchar2(10)      ,/* 替代方式 */
bmea017       number(20,6)      ,/* 部份替代上限比率 */
bmea018       varchar2(10)      ,/* 參照研發中心 */
bmea019       varchar2(256)      ,/* 產品特徵 */
bmeaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmeaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmeaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmeaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmeaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmeaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmeaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmeaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmeaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmeaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmeaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmeaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmeaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmeaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmeaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmeaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmeaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmeaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmeaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmeaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmeaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmeaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmeaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmeaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmeaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmeaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmeaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmeaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmeaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmeaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmea_t add constraint bmea_pk primary key (bmeaent,bmeasite,bmea001,bmea002,bmea003,bmea004,bmea005,bmea006,bmea007,bmea008,bmea019) enable validate;

create  index bmea_01 on bmea_t (bmeaent,bmeasite,bmea001,bmea002,bmea003,bmea004,bmea005,bmea006,bmea007,bmea008);
create unique index bmea_pk on bmea_t (bmeaent,bmeasite,bmea001,bmea002,bmea003,bmea004,bmea005,bmea006,bmea007,bmea008,bmea019);

grant select on bmea_t to tiptop;
grant update on bmea_t to tiptop;
grant delete on bmea_t to tiptop;
grant insert on bmea_t to tiptop;

exit;
