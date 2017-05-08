/* 
================================================================================
檔案代號:fmcy_t
檔案名稱:計提利息單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmcy_t
(
fmcyent       number(5)      ,/* 企業編號 */
fmcydocno       varchar2(20)      ,/* 計息單號 */
fmcysite       varchar2(10)      ,/* 資金中心 */
fmcycomp       varchar2(10)      ,/* 法人 */
fmcydocdt       date      ,/* 日期 */
fmcy001       number(5,0)      ,/* 年度 */
fmcy002       number(5,0)      ,/* 期別 */
fmcyownid       varchar2(20)      ,/* 資料所屬者 */
fmcyowndp       varchar2(10)      ,/* 資料所屬部門 */
fmcycrtid       varchar2(20)      ,/* 資料建立者 */
fmcycrtdp       varchar2(10)      ,/* 資料建立部門 */
fmcycrtdt       timestamp(0)      ,/* 資料創建日 */
fmcymodid       varchar2(20)      ,/* 資料修改者 */
fmcymoddt       timestamp(0)      ,/* 最近修改日 */
fmcycnfid       varchar2(20)      ,/* 資料確認者 */
fmcycnfdt       timestamp(0)      ,/* 資料確認日 */
fmcystus       varchar2(10)      ,/* 狀態碼 */
fmcyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmcy_t add constraint fmcy_pk primary key (fmcyent,fmcydocno) enable validate;

create unique index fmcy_pk on fmcy_t (fmcyent,fmcydocno);

grant select on fmcy_t to tiptop;
grant update on fmcy_t to tiptop;
grant delete on fmcy_t to tiptop;
grant insert on fmcy_t to tiptop;

exit;
