/* 
================================================================================
檔案代號:rtjg_t
檔案名稱:銷售整合開立餘額卷檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table rtjg_t
(
rtjgent       number(5)      ,/* 企業編號 */
rtjgsite       varchar2(10)      ,/* 營運據點 */
rtjgunit       varchar2(10)      ,/* 應用組織 */
rtjgdocno       varchar2(20)      ,/* 單據編號 */
rtjg001       varchar2(30)      ,/* 券號 */
rtjg002       varchar2(10)      ,/* 券種編號 */
rtjg003       number(20,6)      ,/* 券開立金額 */
rtjgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtjgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtjgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtjgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtjgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtjgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtjgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtjgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtjgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtjgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtjgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtjgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtjgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtjgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtjgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtjgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtjgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtjgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtjgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtjgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtjgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtjgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtjgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtjgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtjgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtjgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtjgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtjgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtjgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtjgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtjg_t add constraint rtjg_pk primary key (rtjgent,rtjgdocno,rtjg001) enable validate;

create unique index rtjg_pk on rtjg_t (rtjgent,rtjgdocno,rtjg001);

grant select on rtjg_t to tiptop;
grant update on rtjg_t to tiptop;
grant delete on rtjg_t to tiptop;
grant insert on rtjg_t to tiptop;

exit;
