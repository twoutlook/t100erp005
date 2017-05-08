/* 
================================================================================
檔案代號:pmek_t
檔案名稱:採購變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmek_t
(
pmekent       number(5)      ,/* 企業編號 */
pmeksite       varchar2(10)      ,/* 營運據點 */
pmekdocno       varchar2(20)      ,/* 採購單號 */
pmekseq       number(10,0)      ,/* 採購單項次 */
pmekseq1       number(10,0)      ,/* 項序 */
pmekseq2       number(10,0)      ,/* 分批序 */
pmek001       number(10,0)      ,/* 變更序 */
pmek002       varchar2(20)      ,/* 變更欄位 */
pmek003       varchar2(10)      ,/* 變更類型 */
pmek004       varchar2(255)      ,/* 變更前內容 */
pmek005       varchar2(255)      ,/* 變更後內容 */
pmek006       varchar2(80)      ,/* 最後變更時間 */
pmek007       varchar2(500)      ,/* 欄位說明SQL */
pmekownid       varchar2(20)      ,/* 資料所有者 */
pmekowndp       varchar2(10)      ,/* 資料所屬部門 */
pmekcrtid       varchar2(20)      ,/* 資料建立者 */
pmekcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmekcrtdt       timestamp(0)      ,/* 資料創建日 */
pmekmodid       varchar2(20)      ,/* 資料修改者 */
pmekmoddt       timestamp(0)      ,/* 最近修改日 */
pmekcnfid       varchar2(20)      ,/* 資料確認者 */
pmekcnfdt       timestamp(0)      ,/* 資料確認日 */
pmekstus       varchar2(10)      ,/* 狀態碼 */
pmekud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmekud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmekud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmekud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmekud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmekud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmekud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmekud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmekud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmekud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmekud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmekud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmekud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmekud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmekud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmekud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmekud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmekud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmekud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmekud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmekud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmekud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmekud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmekud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmekud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmekud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmekud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmekud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmekud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmekud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmek_t add constraint pmek_pk primary key (pmekent,pmekdocno,pmekseq,pmekseq1,pmekseq2,pmek001,pmek002) enable validate;

create unique index pmek_pk on pmek_t (pmekent,pmekdocno,pmekseq,pmekseq1,pmekseq2,pmek001,pmek002);

grant select on pmek_t to tiptop;
grant update on pmek_t to tiptop;
grant delete on pmek_t to tiptop;
grant insert on pmek_t to tiptop;

exit;
