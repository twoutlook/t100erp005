/* 
================================================================================
檔案代號:nmbu_t
檔案名稱:繳款單單據來源明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmbu_t
(
nmbuent       number(5)      ,/* 企業編號 */
nmbucomp       varchar2(10)      ,/* 法人 */
nmbudocno       varchar2(20)      ,/* 單據號碼 */
nmbuseq       number(10,0)      ,/* 項次 */
nmbuorga       varchar2(10)      ,/* 來源組織 */
nmbu001       varchar2(10)      ,/* 交易對象 */
nmbu002       varchar2(20)      ,/* 一次性交易對象識別碼 */
nmbu003       varchar2(10)      ,/* 繳款性質 */
nmbu004       varchar2(10)      ,/* 單據來源 */
nmbu005       varchar2(20)      ,/* 單據號碼 */
nmbu006       number(5,0)      ,/* 期別 */
nmbu007       number(20,6)      ,/* 原幣金額 */
nmbu008       varchar2(20)      ,/* 應收帳款待抵單據號碼 */
nmbuownid       varchar2(20)      ,/* 資料所有者 */
nmbuowndp       varchar2(10)      ,/* 資料所屬部門 */
nmbucrtid       varchar2(20)      ,/* 資料建立者 */
nmbucrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbucrtdt       timestamp(0)      ,/* 資料創建日 */
nmbumodid       varchar2(20)      ,/* 資料修改者 */
nmbumoddt       timestamp(0)      ,/* 最近修改日 */
nmbucnfid       varchar2(20)      ,/* 資料確認者 */
nmbucnfdt       timestamp(0)      ,/* 資料確認日 */
nmbustus       varchar2(10)      ,/* 狀態碼 */
nmbuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbu_t add constraint nmbu_pk primary key (nmbuent,nmbucomp,nmbudocno,nmbuseq) enable validate;

create unique index nmbu_pk on nmbu_t (nmbuent,nmbucomp,nmbudocno,nmbuseq);

grant select on nmbu_t to tiptop;
grant update on nmbu_t to tiptop;
grant delete on nmbu_t to tiptop;
grant insert on nmbu_t to tiptop;

exit;
