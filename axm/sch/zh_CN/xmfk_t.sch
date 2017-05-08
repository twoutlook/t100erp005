/* 
================================================================================
檔案代號:xmfk_t
檔案名稱:銷售折扣結算對象檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfk_t
(
xmfkent       number(5)      ,/* 企業編號 */
xmfksite       varchar2(10)      ,/* 營運據點 */
xmfkdocno       varchar2(20)      ,/* 合約單號 */
xmfkseq       number(10,0)      ,/* 項次 */
xmfk001       varchar2(10)      ,/* 訂單客戶 */
xmfk002       varchar2(10)      ,/* 最終客戶 */
xmfkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfk_t add constraint xmfk_pk primary key (xmfkent,xmfkdocno,xmfkseq) enable validate;

create unique index xmfk_pk on xmfk_t (xmfkent,xmfkdocno,xmfkseq);

grant select on xmfk_t to tiptop;
grant update on xmfk_t to tiptop;
grant delete on xmfk_t to tiptop;
grant insert on xmfk_t to tiptop;

exit;
