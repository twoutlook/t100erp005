/* 
================================================================================
檔案代號:pmed_t
檔案名稱:採購合約變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmed_t
(
pmedent       number(5)      ,/* 企業編號 */
pmedsite       varchar2(10)      ,/* 營運據點 */
pmeddocno       varchar2(20)      ,/* 合約單號 */
pmedseq       number(10,0)      ,/* 採購合約項次 */
pmedseq1       number(10,0)      ,/* 累計定價項序 */
pmed001       number(10,0)      ,/* 變更序 */
pmed002       varchar2(20)      ,/* 變更欄位 */
pmed003       varchar2(10)      ,/* 變更類型 */
pmed004       varchar2(255)      ,/* 變更前內容 */
pmed005       varchar2(255)      ,/* 變更後內容 */
pmed006       varchar2(80)      ,/* 最後變更時間 */
pmed007       varchar2(500)      ,/* 欄位說明SQL */
pmedownid       varchar2(20)      ,/* 資料所有者 */
pmedowndp       varchar2(10)      ,/* 資料所屬部門 */
pmedcrtid       varchar2(20)      ,/* 資料建立者 */
pmedcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmedcrtdt       timestamp(0)      ,/* 資料創建日 */
pmedmodid       varchar2(20)      ,/* 資料修改者 */
pmedmoddt       timestamp(0)      ,/* 最近修改日 */
pmedcnfid       varchar2(20)      ,/* 資料確認者 */
pmedcnfdt       timestamp(0)      ,/* 資料確認日 */
pmedstus       varchar2(10)      ,/* 狀態碼 */
pmedud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmedud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmedud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmedud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmedud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmedud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmedud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmedud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmedud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmedud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmedud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmedud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmedud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmedud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmedud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmedud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmedud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmedud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmedud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmedud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmedud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmedud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmedud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmedud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmedud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmedud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmedud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmedud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmedud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmedud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmed_t add constraint pmed_pk primary key (pmedent,pmeddocno,pmedseq,pmedseq1,pmed001,pmed002) enable validate;

create unique index pmed_pk on pmed_t (pmedent,pmeddocno,pmedseq,pmedseq1,pmed001,pmed002);

grant select on pmed_t to tiptop;
grant update on pmed_t to tiptop;
grant delete on pmed_t to tiptop;
grant insert on pmed_t to tiptop;

exit;
