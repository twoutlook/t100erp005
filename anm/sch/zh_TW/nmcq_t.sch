/* 
================================================================================
檔案代號:nmcq_t
檔案名稱:應收票據異動主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmcq_t
(
nmcqent       number(5)      ,/* 企業編碼 */
nmcqcomp       varchar2(10)      ,/* 法人 */
nmcqsite       varchar2(10)      ,/* 資金中心 */
nmcqdocno       varchar2(20)      ,/* 單據號碼 */
nmcqdocdt       date      ,/* 異動日期 */
nmcq001       varchar2(10)      ,/* 異動類別 */
nmcq002       varchar2(20)      ,/* 帳務人員 */
nmcq003       varchar2(10)      ,/* 交易帳戶 */
nmcq004       varchar2(1)      ,/* 重立帳否 */
nmcq005       varchar2(10)      ,/* 轉付對象 */
nmcq006       varchar2(255)      ,/* 備註 */
nmcq007       varchar2(20)      ,/* 帳務單號 */
nmcq008       varchar2(20)      ,/* 帳套二帳務單號 */
nmcq009       varchar2(20)      ,/* 帳套三帳務單號 */
nmcq100       varchar2(10)      ,/* 幣別 */
nmcq101       number(20,10)      ,/* 匯率 */
nmcqstus       varchar2(1)      ,/* 狀態碼 */
nmcqownid       varchar2(20)      ,/* 資料所有者 */
nmcqowndp       varchar2(10)      ,/* 資料所屬部門 */
nmcqcrtid       varchar2(20)      ,/* 資料建立者 */
nmcqcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmcqcrtdt       timestamp(0)      ,/* 資料創建日 */
nmcqmodid       varchar2(20)      ,/* 資料修改者 */
nmcqmoddt       timestamp(0)      ,/* 最近修改日 */
nmcqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmcqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmcqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmcqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmcqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmcqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmcqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmcqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmcqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmcqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmcqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmcqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmcqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmcqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmcqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmcqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmcqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmcqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmcqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmcqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmcqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmcqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmcqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmcqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmcqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmcqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmcqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmcqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmcqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmcqud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmcqcnfid       varchar2(20)      ,/* 資料確認者 */
nmcqcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table nmcq_t add constraint nmcq_pk primary key (nmcqent,nmcqcomp,nmcqdocno) enable validate;

create unique index nmcq_pk on nmcq_t (nmcqent,nmcqcomp,nmcqdocno);

grant select on nmcq_t to tiptop;
grant update on nmcq_t to tiptop;
grant delete on nmcq_t to tiptop;
grant insert on nmcq_t to tiptop;

exit;
