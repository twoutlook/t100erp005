/* 
================================================================================
檔案代號:ecce_t
檔案名稱:料件製程變更上站作業資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ecce_t
(
ecceent       number(5)      ,/* 企業代碼 */
eccesite       varchar2(10)      ,/* 營運據點 */
eccedocno       varchar2(20)      ,/* 申請單號 */
ecce001       varchar2(40)      ,/* 製程料號 */
ecce002       varchar2(10)      ,/* 製程編號 */
ecce003       number(10,0)      ,/* 製程項次 */
ecceseq       number(10,0)      ,/* 項序 */
ecce004       varchar2(10)      ,/* 上站作業 */
ecce005       varchar2(10)      ,/* 上站作業序 */
ecce900       number(10,0)      ,/* 變更序 */
ecce901       varchar2(1)      ,/* 變更類型 */
ecce902       date      ,/* 變更日期 */
ecce905       varchar2(10)      ,/* 變更原因 */
ecce906       varchar2(255)      ,/* 變更備註 */
ecceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecce_t add constraint ecce_pk primary key (ecceent,eccesite,eccedocno,ecce003,ecceseq) enable validate;

create unique index ecce_pk on ecce_t (ecceent,eccesite,eccedocno,ecce003,ecceseq);

grant select on ecce_t to tiptop;
grant update on ecce_t to tiptop;
grant delete on ecce_t to tiptop;
grant insert on ecce_t to tiptop;

exit;
