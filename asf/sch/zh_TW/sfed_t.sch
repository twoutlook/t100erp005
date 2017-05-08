/* 
================================================================================
檔案代號:sfed_t
檔案名稱:重複性生產完工入庫單-倒扣料領料明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table sfed_t
(
sfedent       number(5)      ,/* 企業編號 */
sfedsite       varchar2(10)      ,/* 營運據點 */
sfeddocno       varchar2(20)      ,/* 單號 */
sfed001       varchar2(40)      ,/* 生產料號 */
sfed002       varchar2(30)      ,/* 生產料號BOM特性 */
sfed003       varchar2(256)      ,/* 生產料號特徵 */
sfed004       varchar2(20)      ,/* 倒扣領料單號 */
sfedud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfedud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfedud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfedud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfedud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfedud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfedud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfedud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfedud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfedud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfedud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfedud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfedud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfedud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfedud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfedud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfedud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfedud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfedud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfedud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfedud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfedud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfedud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfedud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfedud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfedud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfedud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfedud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfedud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfedud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfed_t add constraint sfed_pk primary key (sfedent,sfeddocno,sfed004) enable validate;

create unique index sfed_pk on sfed_t (sfedent,sfeddocno,sfed004);

grant select on sfed_t to tiptop;
grant update on sfed_t to tiptop;
grant delete on sfed_t to tiptop;
grant insert on sfed_t to tiptop;

exit;
