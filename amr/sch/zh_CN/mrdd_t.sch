/* 
================================================================================
檔案代號:mrdd_t
檔案名稱:資源領用單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mrdd_t
(
mrddent       number(5)      ,/* 企業編號 */
mrddsite       varchar2(10)      ,/* 營運據點 */
mrdddocno       varchar2(20)      ,/* 保校單號 */
mrddseq       number(10,0)      ,/* 項次 */
mrdd001       varchar2(20)      ,/* 資源編號 */
mrdd002       number(20,6)      ,/* 領用數量 */
mrdd003       varchar2(20)      ,/* 參考單號 */
mrdd004       varchar2(10)      ,/* 參考作業編號 */
mrdd005       varchar2(20)      ,/* 參考機器編號 */
mrdd006       varchar2(255)      ,/* 備註 */
mrdd007       varchar2(10)      ,/* 歸還方式 */
mrdd008       varchar2(20)      ,/* 歸還單號 */
mrdd009       date      ,/* 預計歸還日 */
mrddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrddud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrdd_t add constraint mrdd_pk primary key (mrddent,mrdddocno,mrddseq) enable validate;

create unique index mrdd_pk on mrdd_t (mrddent,mrdddocno,mrddseq);

grant select on mrdd_t to tiptop;
grant update on mrdd_t to tiptop;
grant delete on mrdd_t to tiptop;
grant insert on mrdd_t to tiptop;

exit;
