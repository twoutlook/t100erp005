/* 
================================================================================
檔案代號:glch_t
檔案名稱:損益類科目與權益類科目關係對應檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glch_t
(
glchent       number(5)      ,/* 企業代碼 */
glchownid       varchar2(20)      ,/* 資料所有者 */
glchowndp       varchar2(10)      ,/* 資料所屬部門 */
glchcrtid       varchar2(20)      ,/* 資料建立者 */
glchcrtdp       varchar2(10)      ,/* 資料建立部門 */
glchcrtdt       timestamp(0)      ,/* 資料創建日 */
glchmodid       varchar2(20)      ,/* 資料修改者 */
glchmoddt       timestamp(0)      ,/* 最近修改日 */
glchstus       varchar2(10)      ,/* 狀態碼 */
glchld       varchar2(5)      ,/* 帳套（套）編號 */
glch001       number(5,0)      ,/* 年度 */
glch002       varchar2(24)      ,/* 綜合損益類科目 */
glch003       varchar2(24)      ,/* 權益類對應科目 */
glch004       varchar2(24)      ,/* 結轉類科目 */
glchud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glchud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glchud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glchud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glchud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glchud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glchud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glchud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glchud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glchud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glchud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glchud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glchud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glchud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glchud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glchud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glchud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glchud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glchud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glchud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glchud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glchud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glchud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glchud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glchud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glchud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glchud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glchud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glchud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glchud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glch_t add constraint glch_pk primary key (glchent,glchld,glch001,glch002) enable validate;

create unique index glch_pk on glch_t (glchent,glchld,glch001,glch002);

grant select on glch_t to tiptop;
grant update on glch_t to tiptop;
grant delete on glch_t to tiptop;
grant insert on glch_t to tiptop;

exit;
