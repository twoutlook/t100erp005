/* 
================================================================================
檔案代號:faac_t
檔案名稱:固定資產主要類型檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faac_t
(
faacent       number(5)      ,/* 企業編號 */
faac001       varchar2(20)      ,/* 資產主要類別 */
faac002       varchar2(100)      ,/* 資產性質 */
faac003       varchar2(100)      ,/* 折舊方法 */
faac004       number(10,0)      ,/* 耐用年限 */
faac005       varchar2(1)      ,/* 折畢再提否 */
faac006       number(10,0)      ,/* 折畢再提年限 */
faac007       varchar2(1)      ,/* 是否直接資本化 */
faac008       varchar2(1)      ,/* 保稅否 */
faac009       varchar2(1)      ,/* 保險否 */
faac010       varchar2(1)      ,/* 免稅否 */
faac011       varchar2(1)      ,/* 抵押否 */
faac012       varchar2(1)      ,/* 投資抵減否 */
faac013       number(20,6)      ,/* 本幣投資抵減比率 */
faac014       number(20,6)      ,/* 外幣投資抵減比率 */
faac015       number(10,0)      ,/* 投資抵減補稅年限 */
faac016       number(20,6)      ,/* 殘值率 */
faacownid       varchar2(20)      ,/* 資料所有者 */
faacowndp       varchar2(10)      ,/* 資料所屬部門 */
faaccrtid       varchar2(20)      ,/* 資料建立者 */
faaccrtdp       varchar2(10)      ,/* 資料建立部門 */
faaccrtdt       timestamp(0)      ,/* 資料創建日 */
faacmodid       varchar2(20)      ,/* 資料修改者 */
faacmoddt       timestamp(0)      ,/* 最近修改日 */
faacstus       varchar2(10)      ,/* 狀態碼 */
faacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table faac_t add constraint faac_pk primary key (faacent,faac001) enable validate;

create unique index faac_pk on faac_t (faacent,faac001);

grant select on faac_t to tiptop;
grant update on faac_t to tiptop;
grant delete on faac_t to tiptop;
grant insert on faac_t to tiptop;

exit;
