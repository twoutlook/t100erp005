/* 
================================================================================
檔案代號:mrbf_t
檔案名稱:資源適用機台資源檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mrbf_t
(
mrbfent       number(5)      ,/* 企業編號 */
mrbfsite       varchar2(10)      ,/* 營運據點 */
mrbf001       varchar2(20)      ,/* 資源編號 */
mrbf002       varchar2(20)      ,/* 適用資源編號 */
mrbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrbf_t add constraint mrbf_pk primary key (mrbfent,mrbfsite,mrbf001,mrbf002) enable validate;

create unique index mrbf_pk on mrbf_t (mrbfent,mrbfsite,mrbf001,mrbf002);

grant select on mrbf_t to tiptop;
grant update on mrbf_t to tiptop;
grant delete on mrbf_t to tiptop;
grant insert on mrbf_t to tiptop;

exit;
