/* 
================================================================================
檔案代號:mrbd_t
檔案名稱:資源部件備品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mrbd_t
(
mrbdent       number(5)      ,/* 企業編號 */
mrbdsite       varchar2(10)      ,/* 營運據點 */
mrbd001       varchar2(20)      ,/* 資源編號 */
mrbd002       number(10,0)      ,/* 項次 */
mrbd003       varchar2(40)      ,/* 料號 */
mrbd004       varchar2(255)      ,/* 部位與說明 */
mrbd005       varchar2(10)      ,/* 類別 */
mrbd006       varchar2(10)      ,/* 單位 */
mrbd007       number(20,6)      ,/* 數量 */
mrbd008       number(5,0)      ,/* 耐用月數 */
mrbd009       date      ,/* 上次更換日期 */
mrbd010       date      ,/* 下次更換日期 */
mrbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrbd_t add constraint mrbd_pk primary key (mrbdent,mrbdsite,mrbd001,mrbd002) enable validate;

create unique index mrbd_pk on mrbd_t (mrbdent,mrbdsite,mrbd001,mrbd002);

grant select on mrbd_t to tiptop;
grant update on mrbd_t to tiptop;
grant delete on mrbd_t to tiptop;
grant insert on mrbd_t to tiptop;

exit;
