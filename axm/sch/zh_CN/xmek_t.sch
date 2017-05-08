/* 
================================================================================
檔案代號:xmek_t
檔案名稱:訂單變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmek_t
(
xmekent       number(5)      ,/* 企業編號 */
xmeksite       varchar2(10)      ,/* 營運據點 */
xmekdocno       varchar2(20)      ,/* 訂單單號 */
xmekseq       number(10,0)      ,/* 訂單項次 */
xmekseq1       number(10,0)      ,/* 項序 */
xmekseq2       number(10,0)      ,/* 分批序 */
xmek001       number(10,0)      ,/* 變更序 */
xmek002       varchar2(20)      ,/* 變更欄位 */
xmek003       varchar2(10)      ,/* 變更類型 */
xmek004       varchar2(255)      ,/* 變更前內容 */
xmek005       varchar2(255)      ,/* 變更後內容 */
xmek006       varchar2(80)      ,/* 最後變更時間 */
xmek007       varchar2(500)      ,/* 欄位說明SQL */
xmekownid       varchar2(20)      ,/* 資料所有者 */
xmekowndp       varchar2(10)      ,/* 資料所屬部門 */
xmekcrtid       varchar2(20)      ,/* 資料建立者 */
xmekcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmekcrtdt       timestamp(0)      ,/* 資料創建日 */
xmekmodid       varchar2(20)      ,/* 資料修改者 */
xmekmoddt       timestamp(0)      ,/* 最近修改日 */
xmekcnfid       varchar2(20)      ,/* 資料確認者 */
xmekcnfdt       timestamp(0)      ,/* 資料確認日 */
xmekstus       varchar2(10)      ,/* 狀態碼 */
xmekud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmekud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmekud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmekud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmekud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmekud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmekud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmekud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmekud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmekud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmekud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmekud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmekud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmekud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmekud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmekud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmekud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmekud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmekud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmekud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmekud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmekud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmekud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmekud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmekud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmekud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmekud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmekud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmekud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmekud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmek_t add constraint xmek_pk primary key (xmekent,xmekdocno,xmekseq,xmekseq1,xmekseq2,xmek001,xmek002) enable validate;

create unique index xmek_pk on xmek_t (xmekent,xmekdocno,xmekseq,xmekseq1,xmekseq2,xmek001,xmek002);

grant select on xmek_t to tiptop;
grant update on xmek_t to tiptop;
grant delete on xmek_t to tiptop;
grant insert on xmek_t to tiptop;

exit;
