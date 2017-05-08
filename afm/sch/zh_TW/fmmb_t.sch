/* 
================================================================================
檔案代號:fmmb_t
檔案名稱:投資類型科目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmmb_t
(
fmmbent       number(5)      ,/* 企業代碼 */
fmmb001       varchar2(20)      ,/* 投資類型 */
fmmb002       varchar2(5)      ,/* 帳套 */
fmmb003       varchar2(24)      ,/* 投資本金科目 */
fmmb004       varchar2(24)      ,/* 公允價值變動科目 */
fmmb005       varchar2(24)      ,/* 應收股利/利息科目 */
fmmb006       varchar2(24)      ,/* 公允價值變動損益科目 */
fmmb007       varchar2(24)      ,/* 交割服務費用科目 */
fmmb008       varchar2(24)      ,/* 投資收益科目 */
fmmb009       varchar2(24)      ,/* 利息調整科目 */
fmmb010       varchar2(24)      ,/* 已宣告未發放股利科目 */
fmmb011       varchar2(24)      ,/* 已到期未領取利息科目 */
fmmbownid       varchar2(20)      ,/* 資料所有者 */
fmmbowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmbcrtid       varchar2(20)      ,/* 資料建立者 */
fmmbcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmbcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmbmodid       varchar2(20)      ,/* 資料修改者 */
fmmbmoddt       timestamp(0)      ,/* 最近修改日 */
fmmbstus       varchar2(10)      ,/* 狀態碼 */
fmmbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmb012       varchar2(24)      ,/* 公允價值變動損失科目 */
fmmb013       varchar2(24)      ,/* 投資損失科目 */
fmmb014       varchar2(24)      ,/* 匯兌收益科目 */
fmmb015       varchar2(24)      ,/* 匯兌損失科目 */
fmmb016       varchar2(24)      /* 利息收入科目 */
);
alter table fmmb_t add constraint fmmb_pk primary key (fmmbent,fmmb001,fmmb002) enable validate;

create unique index fmmb_pk on fmmb_t (fmmbent,fmmb001,fmmb002);

grant select on fmmb_t to tiptop;
grant update on fmmb_t to tiptop;
grant delete on fmmb_t to tiptop;
grant insert on fmmb_t to tiptop;

exit;
