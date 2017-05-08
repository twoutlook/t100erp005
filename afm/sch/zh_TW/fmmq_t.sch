/* 
================================================================================
檔案代號:fmmq_t
檔案名稱:公允價值調整單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmq_t
(
fmmqent       number(5)      ,/* 企業代碼 */
fmmqdocno       varchar2(20)      ,/* 公允價值調整賬務單號 */
fmmqdocdt       date      ,/* 單據日期 */
fmmqsite       varchar2(10)      ,/* 賬務中心 */
fmmq001       varchar2(5)      ,/* 帳別 */
fmmq002       number(5,0)      ,/* 年度 */
fmmq003       number(5,0)      ,/* 期別 */
fmmq004       varchar2(20)      ,/* 憑證編號 */
fmmqownid       varchar2(20)      ,/* 資料所有者 */
fmmqowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmqcrtid       varchar2(20)      ,/* 資料建立者 */
fmmqcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmqcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmqmodid       varchar2(20)      ,/* 資料修改者 */
fmmqmoddt       timestamp(0)      ,/* 最近修改日 */
fmmqcnfid       varchar2(20)      ,/* 資料確認者 */
fmmqcnfdt       timestamp(0)      ,/* 資料確認日 */
fmmqpstid       varchar2(20)      ,/* 資料過帳者 */
fmmqpstdt       timestamp(0)      ,/* 資料過帳日 */
fmmqstus       varchar2(10)      ,/* 狀態碼 */
fmmqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmmq_t add constraint fmmq_pk primary key (fmmqent,fmmqdocno) enable validate;

create unique index fmmq_pk on fmmq_t (fmmqent,fmmqdocno);

grant select on fmmq_t to tiptop;
grant update on fmmq_t to tiptop;
grant delete on fmmq_t to tiptop;
grant insert on fmmq_t to tiptop;

exit;
