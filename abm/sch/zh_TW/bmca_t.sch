/* 
================================================================================
檔案代號:bmca_t
檔案名稱:特徵限定用料單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmca_t
(
bmcaent       number(5)      ,/* 企業編號 */
bmcasite       varchar2(10)      ,/* 營運據點 */
bmca001       varchar2(40)      ,/* 主件料號 */
bmca002       varchar2(30)      ,/* 特性代碼 */
bmca003       varchar2(40)      ,/* 元件料號 */
bmca004       varchar2(10)      ,/* 部位編碼 */
bmca005       timestamp(0)      ,/* 生效日期時間 */
bmca007       varchar2(10)      ,/* 作業編號 */
bmca008       varchar2(10)      ,/* 製程段號 */
bmca009       varchar2(30)      ,/* 限定特徵 */
bmcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmcaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmca_t add constraint bmca_pk primary key (bmcaent,bmcasite,bmca001,bmca002,bmca003,bmca004,bmca005,bmca007,bmca008,bmca009) enable validate;

create  index bmca_01 on bmca_t (bmca001,bmca002,bmca003,bmca004,bmca005,bmca007,bmca008,bmca009);
create unique index bmca_pk on bmca_t (bmcaent,bmcasite,bmca001,bmca002,bmca003,bmca004,bmca005,bmca007,bmca008,bmca009);

grant select on bmca_t to tiptop;
grant update on bmca_t to tiptop;
grant delete on bmca_t to tiptop;
grant insert on bmca_t to tiptop;

exit;
