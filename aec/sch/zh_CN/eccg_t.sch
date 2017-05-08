/* 
================================================================================
檔案代號:eccg_t
檔案名稱:料件製程變更資源項目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table eccg_t
(
eccgent       number(5)      ,/* 企業代碼 */
eccgsite       varchar2(10)      ,/* 營運據點 */
eccgdocno       varchar2(20)      ,/* 申請單號 */
eccg001       varchar2(40)      ,/* 製程料號 */
eccg002       varchar2(10)      ,/* 製程編號 */
eccg003       number(10,0)      ,/* 製程項次 */
eccgseq       number(10,0)      ,/* 項序 */
eccg004       varchar2(1)      ,/* 資源類型 */
eccg005       varchar2(10)      ,/* 資源項目 */
eccg006       number(15,3)      ,/* 固定標準工時 */
eccg007       number(15,3)      ,/* 變動標準工時 */
eccg008       number(20,6)      ,/* 變動標準工時批量 */
eccg009       number(20,6)      ,/* 效率 */
eccg900       number(10,0)      ,/* 變更序 */
eccg901       varchar2(1)      ,/* 變更類型 */
eccg902       date      ,/* 變更日期 */
eccg905       varchar2(10)      ,/* 變更原因 */
eccg906       varchar2(255)      ,/* 變更備註 */
eccgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
eccgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
eccgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
eccgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
eccgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
eccgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
eccgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
eccgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
eccgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
eccgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
eccgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
eccgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
eccgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
eccgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
eccgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
eccgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
eccgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
eccgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
eccgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
eccgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
eccgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
eccgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
eccgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
eccgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
eccgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
eccgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
eccgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
eccgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
eccgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
eccgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table eccg_t add constraint eccg_pk primary key (eccgent,eccgsite,eccgdocno,eccg003,eccgseq) enable validate;

create unique index eccg_pk on eccg_t (eccgent,eccgsite,eccgdocno,eccg003,eccgseq);

grant select on eccg_t to tiptop;
grant update on eccg_t to tiptop;
grant delete on eccg_t to tiptop;
grant insert on eccg_t to tiptop;

exit;
