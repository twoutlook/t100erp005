/* 
================================================================================
檔案代號:nmbg_t
檔案名稱:內部資金排程撥入明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmbg_t
(
nmbgent       number(5)      ,/* 企業編碼 */
nmbgdocno       varchar2(20)      ,/* 調度單號 */
nmbgseq       number(10,0)      ,/* 對應撥出序號 */
nmbgseq2       number(10,0)      ,/* 序號 */
nmbg001       varchar2(10)      ,/* 組織代碼 */
nmbg002       varchar2(10)      ,/* 調度項目 */
nmbg003       varchar2(15)      ,/* 開戶銀行 */
nmbg004       varchar2(10)      ,/* 交易帳戶 */
nmbg005       varchar2(10)      ,/* 內部帳戶 */
nmbg006       varchar2(10)      ,/* 幣別 */
nmbg007       number(20,10)      ,/* 匯率 */
nmbg008       number(20,6)      ,/* 原幣金額 */
nmbg009       number(20,6)      ,/* 本幣金額 */
nmbg010       varchar2(10)      ,/* 存提碼 */
nmbg011       varchar2(10)      ,/* 現金變動碼 */
nmbg012       date      ,/* 入帳日期 */
nmbg013       varchar2(20)      ,/* 帳務單號 */
nmbg019       number(20,6)      ,/* 累積利息 */
nmbg020       number(20,6)      ,/* 已還原幣金額 */
nmbg021       varchar2(1)      ,/* 結案否 */
nmbg022       date      ,/* 結案日期 */
nmbg023       varchar2(20)      ,/* 輔助帳套一帳務單號 */
nmbg024       varchar2(20)      ,/* 輔助帳套二帳務單號 */
nmbg025       varchar2(10)      ,/* 內部交易對象 */
nmbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbg_t add constraint nmbg_pk primary key (nmbgent,nmbgdocno,nmbgseq2) enable validate;

create unique index nmbg_pk on nmbg_t (nmbgent,nmbgdocno,nmbgseq2);

grant select on nmbg_t to tiptop;
grant update on nmbg_t to tiptop;
grant delete on nmbg_t to tiptop;
grant insert on nmbg_t to tiptop;

exit;
