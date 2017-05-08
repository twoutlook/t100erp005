/* 
================================================================================
檔案代號:inbg_t
檔案名稱:庫存異常變更申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inbg_t
(
inbgent       number(5)      ,/* 企業編號 */
inbgsite       varchar2(10)      ,/* 營運據點 */
inbgdocno       varchar2(20)      ,/* 單據編號 */
inbgseq       number(10,0)      ,/* 項次 */
inbg001       varchar2(10)      ,/* 變更類型 */
inbg002       varchar2(40)      ,/* 料件編號 */
inbg003       varchar2(10)      ,/* 庫位 */
inbg004       varchar2(10)      ,/* 儲位 */
inbg005       varchar2(256)      ,/* 產品特徵 */
inbg006       varchar2(30)      ,/* 庫存管理特徵 */
inbg007       varchar2(30)      ,/* 批號 */
inbg008       varchar2(10)      ,/* 庫存單位 */
inbg009       varchar2(30)      ,/* 製造批號 */
inbg010       varchar2(30)      ,/* 製造序號 */
inbg011       varchar2(256)      ,/* 變更內容 */
inbg012       varchar2(1)      ,/* 變更部分數量 */
inbg031       varchar2(10)      ,/* 理由碼 */
inbg032       varchar2(255)      ,/* 備註 */
inbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inbg_t add constraint inbg_pk primary key (inbgent,inbgdocno,inbgseq) enable validate;

create unique index inbg_pk on inbg_t (inbgent,inbgdocno,inbgseq);

grant select on inbg_t to tiptop;
grant update on inbg_t to tiptop;
grant delete on inbg_t to tiptop;
grant insert on inbg_t to tiptop;

exit;
