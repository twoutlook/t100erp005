/* 
================================================================================
檔案代號:xmed_t
檔案名稱:銷售合約變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmed_t
(
xmedent       number(5)      ,/* 企業編號 */
xmedsite       varchar2(10)      ,/* 營運據點 */
xmeddocno       varchar2(20)      ,/* 合約單號 */
xmedseq       number(10,0)      ,/* 銷售合約項次 */
xmedseq1       number(10,0)      ,/* 累計定價項序 */
xmed001       number(10,0)      ,/* 變更序 */
xmed002       varchar2(20)      ,/* 變更欄位 */
xmed003       varchar2(10)      ,/* 變更類型 */
xmed004       varchar2(255)      ,/* 變更前內容 */
xmed005       varchar2(255)      ,/* 變更後內容 */
xmed006       varchar2(80)      ,/* 最後變更時間 */
xmed007       varchar2(500)      ,/* 欄位說明SQL */
xmedownid       varchar2(20)      ,/* 資料所有者 */
xmedowndp       varchar2(10)      ,/* 資料所屬部門 */
xmedcrtid       varchar2(20)      ,/* 資料建立者 */
xmedcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmedcrtdt       timestamp(0)      ,/* 資料創建日 */
xmedmodid       varchar2(20)      ,/* 資料修改者 */
xmedmoddt       timestamp(0)      ,/* 最近修改日 */
xmedcnfid       varchar2(20)      ,/* 資料確認者 */
xmedcnfdt       timestamp(0)      ,/* 資料確認日 */
xmedstus       varchar2(10)      ,/* 狀態碼 */
xmedud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmedud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmedud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmedud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmedud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmedud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmedud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmedud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmedud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmedud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmedud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmedud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmedud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmedud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmedud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmedud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmedud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmedud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmedud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmedud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmedud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmedud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmedud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmedud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmedud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmedud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmedud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmedud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmedud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmedud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmed_t add constraint xmed_pk primary key (xmedent,xmeddocno,xmedseq,xmedseq1,xmed001,xmed002) enable validate;

create unique index xmed_pk on xmed_t (xmedent,xmeddocno,xmedseq,xmedseq1,xmed001,xmed002);

grant select on xmed_t to tiptop;
grant update on xmed_t to tiptop;
grant delete on xmed_t to tiptop;
grant insert on xmed_t to tiptop;

exit;
