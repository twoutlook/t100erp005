/* 
================================================================================
檔案代號:oohe_t
檔案名稱:控制組客戶檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohe_t
(
ooheent       number(5)      ,/* 企業編號 */
oohe001       varchar2(10)      ,/* 控制組編號 */
oohe002       varchar2(10)      ,/* 客戶編號 */
oohe003       date      ,/* 生效日期 */
oohe004       date      ,/* 失效日期 */
ooheud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooheud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooheud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooheud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooheud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooheud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooheud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooheud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooheud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooheud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooheud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooheud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooheud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooheud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooheud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooheud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooheud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooheud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooheud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooheud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooheud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooheud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooheud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooheud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooheud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooheud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooheud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooheud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooheud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooheud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohe_t add constraint oohe_pk primary key (ooheent,oohe001,oohe002) enable validate;

create  index oohe_01 on oohe_t (oohe003);
create  index oohe_02 on oohe_t (oohe004);
create unique index oohe_pk on oohe_t (ooheent,oohe001,oohe002);

grant select on oohe_t to tiptop;
grant update on oohe_t to tiptop;
grant delete on oohe_t to tiptop;
grant insert on oohe_t to tiptop;

exit;
