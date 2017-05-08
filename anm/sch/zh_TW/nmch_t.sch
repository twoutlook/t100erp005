/* 
================================================================================
檔案代號:nmch_t
檔案名稱:應付票據異動主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmch_t
(
nmchent       number(5)      ,/* 企業編碼 */
nmchcomp       varchar2(10)      ,/* 法人 */
nmchsite       varchar2(10)      ,/* 資金中心 */
nmchdocno       varchar2(20)      ,/* 單據號碼 */
nmchdocdt       date      ,/* 異動日期 */
nmch001       varchar2(10)      ,/* 異動類別 */
nmch002       varchar2(20)      ,/* 帳務人員 */
nmch003       varchar2(10)      ,/* 交易帳戶編碼 */
nmch004       varchar2(1)      ,/* 重立帳否 */
nmch006       varchar2(255)      ,/* 備註 */
nmch007       varchar2(20)      ,/* 主帳套帳務單號 */
nmch008       varchar2(20)      ,/* 次帳一帳套帳務單號 */
nmch009       varchar2(255)      ,/* 次帳二帳套帳務單號 */
nmch100       varchar2(10)      ,/* 幣別 */
nmch101       number(20,10)      ,/* 匯率 */
nmchstus       varchar2(10)      ,/* 狀態碼 */
nmchownid       varchar2(20)      ,/* 資料所有者 */
nmchowndp       varchar2(10)      ,/* 資料所屬部門 */
nmchcrtid       varchar2(20)      ,/* 資料建立者 */
nmchcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmchcrtdt       timestamp(0)      ,/* 資料創建日 */
nmchmodid       varchar2(20)      ,/* 資料修改者 */
nmchmoddt       timestamp(0)      ,/* 最近修改日 */
nmchcnfid       varchar2(20)      ,/* 資料確認者 */
nmchcnfdt       timestamp(0)      ,/* 資料確認日 */
nmchud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmchud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmchud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmchud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmchud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmchud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmchud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmchud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmchud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmchud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmchud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmchud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmchud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmchud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmchud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmchud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmchud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmchud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmchud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmchud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmchud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmchud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmchud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmchud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmchud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmchud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmchud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmchud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmchud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmchud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmch010       varchar2(1)      /* 作業類別 */
);
alter table nmch_t add constraint nmch_pk primary key (nmchent,nmchcomp,nmchdocno) enable validate;

create unique index nmch_pk on nmch_t (nmchent,nmchcomp,nmchdocno);

grant select on nmch_t to tiptop;
grant update on nmch_t to tiptop;
grant delete on nmch_t to tiptop;
grant insert on nmch_t to tiptop;

exit;
