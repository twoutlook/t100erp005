/* 
================================================================================
檔案代號:mrbc_t
檔案名稱:資源儀錶檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mrbc_t
(
mrbcent       number(5)      ,/* 企業編號 */
mrbcsite       varchar2(10)      ,/* 營運據點 */
mrbc001       varchar2(20)      ,/* 資源編號 */
mrbc002       varchar2(10)      ,/* 儀錶編號 */
mrbc003       varchar2(255)      ,/* 儀錶名稱 */
mrbc004       varchar2(10)      ,/* 儀錶類型 */
mrbc005       varchar2(10)      ,/* 讀值類型 */
mrbc006       varchar2(80)      ,/* 度量單位 */
mrbc007       number(20,6)      ,/* 工作範圍下限 */
mrbc008       number(20,6)      ,/* 工作範圍上限 */
mrbc009       number(20,6)      ,/* 復歸值 */
mrbc010       number(20,6)      ,/* 最新數值 */
mrbc011       date      ,/* 更新日期 */
mrbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrbc_t add constraint mrbc_pk primary key (mrbcent,mrbcsite,mrbc001,mrbc002) enable validate;

create unique index mrbc_pk on mrbc_t (mrbcent,mrbcsite,mrbc001,mrbc002);

grant select on mrbc_t to tiptop;
grant update on mrbc_t to tiptop;
grant delete on mrbc_t to tiptop;
grant insert on mrbc_t to tiptop;

exit;
