/* 
================================================================================
檔案代號:stbg_t
檔案名稱:跨月費用單明細資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbg_t
(
stbgent       number(5)      ,/* 企業編號 */
stbgunit       varchar2(10)      ,/* 來源組織 */
stbgsite       varchar2(10)      ,/* 營運組織 */
stbgdocno       varchar2(20)      ,/* 單據編號 */
stbgseq       number(10,0)      ,/* 項次 */
stbgstus       varchar2(10)      ,/* 狀態 */
stbg001       number(5,0)      ,/* 年度 */
stbg002       number(5,0)      ,/* 月份 */
stbg003       date      ,/* 單據日期 */
stbg004       varchar2(20)      ,/* 合同編號 */
stbg005       varchar2(10)      ,/* 供應商編號 */
stbg006       varchar2(10)      ,/* 結算方式 */
stbg007       varchar2(10)      ,/* 結算類型 */
stbg008       varchar2(10)      ,/* 結算中心 */
stbg009       varchar2(10)      ,/* 費用編號 */
stbg010       varchar2(10)      ,/* 費用總類 */
stbg011       varchar2(10)      ,/* 幣別 */
stbg012       varchar2(10)      ,/* 稅別 */
stbg013       number(20,6)      ,/* 費用金額 */
stbg014       varchar2(10)      ,/* 所屬營運組織 */
stbg015       varchar2(10)      ,/* 所屬部門 */
stbg016       varchar2(10)      ,/* 所屬品類 */
stbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stbg_t add constraint stbg_pk primary key (stbgent,stbgdocno,stbgseq) enable validate;

create unique index stbg_pk on stbg_t (stbgent,stbgdocno,stbgseq);

grant select on stbg_t to tiptop;
grant update on stbg_t to tiptop;
grant delete on stbg_t to tiptop;
grant insert on stbg_t to tiptop;

exit;
